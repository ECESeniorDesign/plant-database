defmodule Backend.PageControllerTest do
  use Backend.ConnCase

  test "GET /" do
    %Backend.Plant{
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
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Featured Plant"
  end
end
