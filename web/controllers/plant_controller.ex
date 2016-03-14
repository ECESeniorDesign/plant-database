defmodule Backend.PlantController do
  use Backend.Web, :controller
  import Ecto.Query

  def compatible(conn, %{"ids" => ids}) do
    query = from plant in Plant,
            where: plant.id in ^ids
    plants = Repo.all(query)
    compatible_query = Enum.reduce plants, Plant, fn(plant, query) ->
      Plant.compatible_with(query, Map.from_struct(plant))
    end
    plants = Repo.all(compatible_query)
    render conn, plants: plants
  end

  def index(conn, _params) do
    plants = Repo.all(Plant)
    render conn, plants: plants
  end

  def show(conn, %{"id" => id}) do
    plant = Repo.get(Plant, id)
    render conn, plant: plant
  end

end
