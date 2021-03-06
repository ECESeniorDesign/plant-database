defmodule Backend.PlantControllerTest do
  use Backend.ConnCase
  alias Backend.Plant
  alias Backend.Repo
  alias Ecto.Adapters.SQL

  setup do
    on_exit fn ->
      SQL.Sandbox.mode(Repo, {:shared, self()})
    end
  end

  test "/index returns a list of plants" do
    plants_as_json = 
      %Plant{
        name: "Orchid",
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
      }
      |> Repo.insert!
      |> List.wrap
      |> Poison.encode!
    response = build_conn(:get, "/api/plants") |> send_request
    assert response.status == 200
    assert response.resp_body == plants_as_json
  end

  test "/index with params shows a list of compatible plants" do
    plants = [
      %Plant{
        name: "P1",
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
      },
      %Plant{
        name: "P2",
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
      }
    ]

    plants_as_json = for plant <- plants do
      Repo.insert!(plant)
    end |> Poison.encode!

    # Incompatible plant
    %Plant{
      name: "P3",
      photo_url: "path_to_orchid.png",
      water_ideal: 465.0,
      water_tolerance: 5.0,
      light_ideal: 30.0,
      light_tolerance: 10.0,
      humidity_ideal: 0.72,
      humidity_tolerance: 0.07,
      temperature_ideal: 55.2,
      temperature_tolerance: 12.3,
      maturity: 85,
    } |> Repo.insert!

    [plant | _rest] = Repo.all(Plant)
    response = build_conn(:post, "/api/plants/compatible", %{ids: [plant.id]}) |> send_request
    assert response.status == 200
    assert response.resp_body == plants_as_json

  end

  test "/index with params shows a list of compatible plants passing multiple" do
    plants = [
      %Plant{
        name: "P1",
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
      },
      %Plant{
        name: "P2",
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
      }
    ]

    plants_as_json = for plant <- plants do
      Repo.insert!(plant)
    end |> Poison.encode!

    # Incompatible plant
    %Plant{
      name: "P3",
      photo_url: "path_to_orchid.png",
      water_ideal: 465.0,
      water_tolerance: 5.0,
      light_ideal: 30.0,
      light_tolerance: 10.0,
      humidity_ideal: 0.72,
      humidity_tolerance: 0.07,
      temperature_ideal: 55.2,
      temperature_tolerance: 12.3,
      maturity: 85,
    } |> Repo.insert!

    [plant1, plant2 | _rest] = Repo.all(Plant)
    response = build_conn(:post, "/api/plants/compatible", %{ids: [plant1.id, plant2.id]}) |> send_request
    assert response.status == 200
    assert response.resp_body == plants_as_json

  end

  test "/show returns a single plant with the id" do
    plant_as_json =
      %Plant{
        name: "Orchid",
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
      }
      |> Repo.insert!
      |> Poison.encode!
    response = build_conn(:get, "/api/plants/#{(Repo.all(Plant) |> hd).id}") |> send_request
    assert response.status == 200
    assert response.resp_body == plant_as_json
  end

  @opts Backend.Router.init([])
  defp send_request(conn) do
    conn
    |> Backend.Router.call(@opts)
  end
  
end
