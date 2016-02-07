defmodule Backend.PlantController do
  use Backend.Web, :controller

  def index(conn, _params) do
    plants = Repo.all(Plant)
    render conn, plants: plants
  end

  def show(conn, %{"id" => id}) do
    plant = Repo.get(Plant, id)
    render conn, plant: plant
  end

end

# create token with: Phoenix.Token.sign(Backend.Endpoint, "user", user_id)
# verify with: Phoenix.Token.verify(Backend.Endpoint, "user", token, max_age: 1209600)
