defmodule Backend.TokenController do

  use Backend.Web, :controller

  # plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => %{"username" => username, "password" => password }}) do
    Backend.Authenticator.authenticate_user(username, password)
      |> send_token(conn)
  end

  def create(conn, %{"token" => token}) do
    Backend.Authenticator.authenticate_token(token)
      |> send_token(conn)
  end

  defp send_token(:invalid, conn) do
    conn
      |> send_resp(403, "Invalid Credentials")
  end

  defp send_token(user_id, conn) do
    conn
      |> render token: Phoenix.Token.sign(Backend.Endpoint, "user", user_id)
  end

end