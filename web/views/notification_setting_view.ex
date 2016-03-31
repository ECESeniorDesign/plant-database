defmodule Backend.NotificationSettingView do
  use Backend.Web, :view

  def render("show.json", %{data: data}) do
    data
  end

end
