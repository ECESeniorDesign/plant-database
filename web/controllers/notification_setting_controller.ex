defmodule Backend.NotificationSettingController do
  use Backend.Web, :controller

  def update(conn, %{"token" => token, "email" => email, "push" => push}) do
    user_id = Backend.Authenticator.authenticate_token(token)
    case user_id do
      :invalid -> send_resp(conn, 403, "Invalid Credentials")
      _ ->
        user = Repo.get(User, user_id)
          |> Repo.preload :notification_setting
        Backend.NotificationSetting.changeset(user.notification_setting, %{"email" => email, "push" => push})
          |> Repo.update!
        send_resp(conn, 200, "OK")
    end
  end

  # Not exactly restful

  def update(conn, %{"token" => token}) do
    user_id = Backend.Authenticator.authenticate_token(token)
    case user_id do
      :invalid -> send_resp(conn, 403, "Invalid Credentials")
      _ ->
        user = Repo.get(User, user_id)
          |> Repo.preload :notification_setting
        render conn, "show.json", data: %{"email" => user.notification_setting.email, "push" => user.notification_setting.push}
    end
  end
  
end
