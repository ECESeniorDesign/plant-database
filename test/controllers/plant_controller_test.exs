defmodule Backend.PlantControllerTest do
  use Backend.ConnCase
  alias Backend.Plant
  alias Backend.Repo
  alias Ecto.Adapters.SQL

  setup do
    on_exit fn ->
      SQL.restart_test_transaction(Repo)
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
        acidity_ideal: 7.0,
        acidity_tolerance: 0.6,
        humidity_ideal: 0.72,
        humidity_tolerance: 0.07,
        maturity: 85,
      }
      |> Repo.insert!
      |> List.wrap
      |> Poison.encode!
    response = conn(:get, "/api/plants") |> send_request
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
        acidity_ideal: 7.0,
        acidity_tolerance: 0.6,
        humidity_ideal: 0.72,
        humidity_tolerance: 0.07,
        maturity: 85,
      }
      |> Repo.insert!
      |> Poison.encode!
    response = conn(:get, "/api/plants/#{(Repo.all(Plant) |> hd).id}") |> send_request
    assert response.status == 200
    assert response.resp_body == plant_as_json
  end

  @opts Backend.Router.init([])
  defp send_request(conn) do
    conn
    |> Backend.Router.call(@opts)
  end
  
end
