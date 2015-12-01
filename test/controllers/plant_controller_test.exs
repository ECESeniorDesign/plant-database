defmodule Backend.PlantControllerTest do
  use ExUnit.Case, async: false
  use Plug.Test
  alias Backend.Plant
  alias Backend.Repo
  
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
      |> Repo.insert
      |> get_plants
      |> List.wrap
      |> Poison.encode!
    response = conn(:get, "/api/plants") |> send_request
    assert response.status == 200
    assert response.resp_body == plants_as_json
  end
  @opts Backend.Router.init([])
  defp send_request(conn) do
    conn
    |> Backend.Router.call(@opts)
  end
  
  defp get_plants({:ok, plants}) do
    plants
  end
  
end
