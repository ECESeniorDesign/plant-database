defmodule Backend.NotificationController do
  use Backend.Web, :controller

  def notify(conn, %{"token" => token, "title" => title, "message" => message}) do
    user_id = Backend.Authenticator.authenticate_token(token)
    case user_id do
      :invalid -> send_resp(conn, 403, "Invalid Credentials")
      _ ->
        user = Repo.get(User, user_id)
          |> Repo.preload([:devices, :notification_setting])
        setting = user.notification_setting
        if setting.email, do: Backend.Mailer.send_notification_email(user.email, title, message)
        if setting.push do
          for device <- user.devices do
            APNS.push :app1_dev_pool, device.device_id, message
          end
        end
        send_resp(conn, 200, "OK")
    end
  end
  
end