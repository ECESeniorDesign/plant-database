defmodule Backend.PlantView do
  use Backend.Web, :view

  def render("index.json", %{plants: plants}) do
    plants
  end
end
