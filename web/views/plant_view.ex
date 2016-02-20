defmodule Backend.PlantView do
  use Backend.Web, :view

  def render("index.json", %{plants: plants}) do
    plants
  end

  def render("compatible.json", %{plants: plants}) do
    plants
  end

  def render("show.json", %{plant: plant}) do
    plant
  end

end
