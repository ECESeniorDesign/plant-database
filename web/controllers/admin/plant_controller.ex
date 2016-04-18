defmodule Backend.Admin.PlantController do
  use Backend.Web, :controller
  import Ecto.Query

  plug :authorize

  def index(conn, _params) do
    plants = Repo.all(Plant)
    render conn, "index.html", plants: plants
  end

  def show(conn, %{"id" => id}) do
    plant = Repo.get(Plant, id)
    render conn, "plant.html", plant: plant
  end

  def new(conn, _params) do
    changeset = Plant.changeset(%Plant{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"plant" => plant_params}) do
    changeset = Plant.changeset(%Plant{}, plant_params)
    case Repo.insert changeset do
      {:ok, plant} ->
        conn
        |> put_flash(:info, "\"#{plant.name}\" added.")
        |> redirect to: plant_path(conn, :index)
      {:error, changeset} ->
        conn
        |> render "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => id}) do
    plant = Repo.get(Plant, id)
    changeset = Plant.changeset(plant)
    render conn, "edit.html", changeset: changeset
  end

  def update(conn, %{"id" => id, "plant" => plant_params}) do
    plant = Repo.get(Plant, id)
    changeset = Plant.changeset(plant, plant_params)
    case Repo.update changeset do
      {:ok, plant} ->
        conn
        |> put_flash(:info, "\"#{plant.name}\" updated.")
        |> redirect to: plant_path(conn, :index)
      {:error, changeset} ->
        conn
        |> render "edit.html", changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    case Repo.get(Plant, id) |> Repo.delete do
      {:ok, plant} ->
        conn
        |> put_flash(:info, "\"#{plant.name}\" deleted.")
        |> redirect to: plant_path(conn, :index)
      {:error, plant} ->
        conn
        |> put_flash(:error, "Could not delete \"#{plant.name}\".")
        |> redirect to: plant_path(conn, :index)
    end
  end

  defp authorize(conn, _) do
    if can_access(conn) do
      conn
    else
      conn
      |> put_flash(:error, "You can't access that page.")
      |> redirect(to: "/")
      |> halt
    end
  end

  defp can_access(conn) do
    case current_user(conn) do
      nil -> false
      %Backend.User{admin: admin} -> admin
    end
  end

end
