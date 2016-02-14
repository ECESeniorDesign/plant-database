defmodule Backend.NotificationController do
  use Backend.Web, :controller

  def notify(conn, %{"token" => token, "title" => title, "message" => message}) do
    user_id = Backend.Authenticator.authenticate_token(token)
    case user_id do
      :invalid -> send_resp(conn, 403, "Invalid Credentials")
      _ ->
        user = Repo.get(User, user_id)
        Backend.Mailer.send_notification_email(user.email, title, message)
        send_resp(conn, 200, "OK")
    end
  end
  
end