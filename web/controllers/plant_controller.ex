defmodule Backend.PlantController do
  use Backend.Web, :controller
  alias Backend.Repo
  alias Backend.Plant
  
  def index(conn, _params) do
    plants = Repo.all(Plant)
    render conn, plants: plants
  end
end
