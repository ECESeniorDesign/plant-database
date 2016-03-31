defmodule Backend.DeviceController do
  use Backend.Web, :controller

  def create(conn, %{"token" => token, "device_id" => device_id}) do
    user_id = Backend.Authenticator.authenticate_token(token)
    case user_id do
      :invalid -> send_resp(conn, 403, "Invalid Credentials")
      _ ->
        user = Repo.get(User, user_id)
        changeset = Backend.Device.changeset(%Backend.Device{}, %{"device_id" => device_id, "user_id" => user_id})
        case Repo.insert changeset do
          {:ok, _} -> send_resp(conn, 200, "OK")
          _ -> send_resp(conn, 200, "Already Added")
        end
    end
  end
end
