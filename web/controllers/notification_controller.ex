defmodule Backend.NotificationController do
  use Backend.Web, :controller

  def notify(conn, %{"token" => token, "plant_name" => plant_name}) do
    user_id = Backend.Authenticator.authenticate_token(token)
    case user_id do
      :invalid -> send_resp(conn, 403, "Invalid Credentials")
      _ ->
        user = Repo.get(User, user_id)
        Backend.Mailer.send_notification_email(user.email, plant_name)
        send_resp(conn, 200, "OK")
    end
  end
  
end