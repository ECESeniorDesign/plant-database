defmodule Backend.TokenView do
  use Backend.Web, :view

  def render("create.json", %{token: token}) do
    %{token: token}
  end

  def render("create.json", %{error: true}) do
    %{}
  end

end
