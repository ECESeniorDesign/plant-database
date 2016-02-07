defmodule Backend.PlantView do
  use Backend.Web, :view

  def render("index.json", %{plants: plants}) do
    plants
  end

  def render("show.json", %{plant: plant, token: token}) do
    %{plant: plant, token: token}
  end

end
