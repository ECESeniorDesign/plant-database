defmodule Backend.PageController do
  use Backend.Web, :controller

  def index(conn, _params) do
    plant = Backend.Plant |> Backend.Repo.all |> Enum.random
    render conn, "index.html", plant: plant
  end
end
