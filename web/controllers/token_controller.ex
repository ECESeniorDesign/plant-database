defmodule Backend.TokenController do

  use Backend.Web, :controller

  # plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    user = if is_nil(user_params["username"]) do
      nil
    else
      Repo.get_by(User, username: user_params["username"])
    end
    user
      |> get_token(user_params["password"], conn)
  end

  def create(conn, %{"token" => token}) do
    get_token(token, conn)
  end

  defp get_token(user, password, conn) when is_nil(user) do
    conn
      |> send_resp(401, "Invalid Credentials")
  end

  defp get_token(user, password, conn) when is_map(user) do
    cond do
      Comeonin.Bcrypt.checkpw(password, user.encrypted_password) ->
        conn
          |> send_token(user.id)
      true ->
        conn
          |> send_resp(401, "Invalid Credentials")
    end
  end

  defp get_token(token, conn) do
    case Phoenix.Token.verify(Backend.Endpoint, "user", token, max_age: 1209600) do
      {:ok, user_id} ->
        conn
          |> send_token(user_id)
      {:error, _} ->
        conn
          |> send_resp(401, "Invalid Credentials")
    end
  end

  defp send_token(conn, user_id) do
    conn
      |> render token: Phoenix.Token.sign(Backend.Endpoint, "user", user_id)
  end

end