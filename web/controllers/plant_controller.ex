defmodule Backend.PlantController do
  use Backend.Web, :controller
  alias Backend.Repo
  alias Backend.Plant
  
  def index(conn, _params) do
    plants = Repo.all(Plant)
    render conn, plants: plants
  end

  def show(conn, %{"id" => id}) do
    plant = Repo.get(Plant, id)
    render conn, plant: plant
  end

end
