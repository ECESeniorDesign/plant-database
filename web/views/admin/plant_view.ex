defmodule Backend.Admin.PlantView do
  use Backend.Web, :view
  import Ecto.Query

  def compatible_plants(plant) do
    compatible = from p in Backend.Plant.compatible_with(Backend.Plant, Map.from_struct(plant)),
                 where: p.id != ^plant.id,
                 select: p
    plants = for plant <- Backend.Repo.all compatible do
      plant.name
    end
    case plants do
      []  -> "None"
      _   -> Enum.join(plants, ", ")
    end
  end
end