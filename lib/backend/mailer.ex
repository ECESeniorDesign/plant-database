defmodule Backend.Mailer do
  use Mailgun.Client, domain: "https://api.mailgun.net/v3/sandbox0554392105884a0b8c41e3b610d97268.mailgun.org",
                      key: "key-a4acb1ea1569cda49e36301e79dc81e9"

  @from "greenhouse@eceseniordesign.com"

  def send_notification_email(email, title, message) do
    send_email to: email,
               from: @from,
               subject: title,
               text: message
  end

end