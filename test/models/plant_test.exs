defmodule Backend.PlantTest do
  use Backend.ModelCase

  alias Backend.Plant
  alias Backend.Repo

  import Ecto.Query

  alias Ecto.Adapters.SQL

  setup do
    on_exit fn ->
      SQL.Sandbox.mode(Repo, {:shared, self()})
    end
  end

  test "gets plants compatible with plant" do
    compatible_plants = [
      %Plant{
        name: "Compatible1",
        photo_url: "path_to_orchid.png",
        water_ideal: 45.0,
        water_tolerance: 5.0,
        light_ideal: 30.0,
        light_tolerance: 10.0,
        humidity_ideal: 0.72,
        humidity_tolerance: 0.07,
        temperature_ideal: 55.2,
        temperature_tolerance: 12.3,
        maturity: 85,
        } |> Repo.insert!,
      %Plant{
        name: "Compatible2",
        photo_url: "path_to_orchid.png",
        water_ideal: 50.0,
        water_tolerance: 5.0,
        light_ideal: 30.0,
        light_tolerance: 10.0,
        humidity_ideal: 0.72,
        humidity_tolerance: 0.07,
        temperature_ideal: 55.2,
        temperature_tolerance: 12.3,
        maturity: 85,
      } |> Repo.insert!
    ]
    _incompatible_plants = [
      %Plant{
        name: "Incompatible",
        photo_url: "path_to_orchid.png",
        water_ideal: 65.0,
        water_tolerance: 5.0,
        light_ideal: 30.0,
        light_tolerance: 10.0,
        humidity_ideal: 0.72,
        humidity_tolerance: 0.07,
        temperature_ideal: 55.2,
        temperature_tolerance: 12.3,
        maturity: 85,
      } |> Repo.insert!
    ]

    plant = %{
        water_ideal: 53.0,
        water_tolerance: 5.0,
        light_ideal: 30.0,
        light_tolerance: 10.0,
        humidity_ideal: 0.72,
        humidity_tolerance: 0.07,
        temperature_ideal: 55.2,
        temperature_tolerance: 12.3,
      }

    assert Repo.all(Plant.compatible_with(plant)) == compatible_plants

  end

  test "gets plants compatible with plant subject to another query" do
    compatible_plants = [
      %Plant{
        name: "Compatible1",
        photo_url: "path_to_orchid.png",
        water_ideal: 45.0,
        water_tolerance: 5.0,
        light_ideal: 30.0,
        light_tolerance: 10.0,
        humidity_ideal: 0.72,
        humidity_tolerance: 0.07,
        temperature_ideal: 55.2,
        temperature_tolerance: 12.3,
        maturity: 85,
        } |> Repo.insert!,
      %Plant{
        name: "Compatible2",
        photo_url: "path_to_orchid.png",
        water_ideal: 50.0,
        water_tolerance: 5.0,
        light_ideal: 30.0,
        light_tolerance: 10.0,
        humidity_ideal: 0.72,
        humidity_tolerance: 0.07,
        temperature_ideal: 55.2,
        temperature_tolerance: 12.3,
        maturity: 85,
      } |> Repo.insert!
    ]
    _incompatible_plants = [
      %Plant{
        name: "Incompatible",
        photo_url: "path_to_orchid.png",
        water_ideal: 65.0,
        water_tolerance: 5.0,
        light_ideal: 30.0,
        light_tolerance: 10.0,
        humidity_ideal: 0.72,
        humidity_tolerance: 0.07,
        temperature_ideal: 55.2,
        temperature_tolerance: 12.3,
        maturity: 85,
      } |> Repo.insert!
    ]

    plant = %{
        water_ideal: 53.0,
        water_tolerance: 5.0,
        light_ideal: 30.0,
        light_tolerance: 10.0,
        humidity_ideal: 0.72,
        humidity_tolerance: 0.07,
        temperature_ideal: 55.2,
        temperature_tolerance: 12.3,
      }
    [match | _] = compatible_plants
    query = Plant
              |> where(water_ideal: 45.0)
              |> Plant.compatible_with(plant)
    assert Repo.all(query) == [match]

  end


end
