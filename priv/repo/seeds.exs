# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Backend.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Backend.Repo
alias Backend.Plant

plants = [
  # All of the conditions are bogus, by the way...
  %Plant{
    name: "Orchid",
    photo_url: "http://www.homedepot.com/catalog/productImages/400/27/270e87cb-7a3c-48ea-aca8-996446e1c061_400.jpg",
    water_ideal: 45.0,
    water_tolerance: 5.0,
    light_ideal: 30.0,
    light_tolerance: 10.0,
    acidity_ideal: 7.0,
    acidity_tolerance: 0.6,
    humidity_ideal: 0.72,
    humidity_tolerance: 0.07,
    maturity: 85,
  },
  %Plant{
    name: "Onion",
    photo_url: "https://pbs.twimg.com/profile_images/595950387003166720/4BpRufhU.jpg",
    water_ideal: 35.0,
    water_tolerance: 5.0,
    light_ideal: 60.0,
    light_tolerance: 10.0,
    acidity_ideal: 9.0,
    acidity_tolerance: 2.6,
    humidity_ideal: 0.42,
    humidity_tolerance: 0.27,
    maturity: 185,
  },
  %Plant{
    name: "Lavender",
    photo_url: "http://images.agoramedia.com/everydayhealth/gcms/Lavender-Natural-oils-for-body-pg-full.jpg",
    water_ideal: 25.0,
    water_tolerance: 10.0,
    light_ideal: 50.0,
    light_tolerance: 10.0,
    acidity_ideal: 6.0,
    acidity_tolerance: 2.6,
    humidity_ideal: 0.42,
    humidity_tolerance: 0.12,
    maturity: 90,
  },
  %Plant{
    name: "Rosemary",
    photo_url: "http://img1.cookinglight.timeinc.net/sites/default/files/styles/400xvariable/public/image/2009/09/0909p70-rosemary-m.jpg?itok=VnPtQBxY",
    water_ideal: 55.0,
    water_tolerance: 20.0,
    light_ideal: 50.0,
    light_tolerance: 50.0,
    acidity_ideal: 7.0,
    acidity_tolerance: 1.6,
    humidity_ideal: 0.42,
    humidity_tolerance: 0.17,
    maturity: 15,
  },
]

for plant <- plants do
  Repo.insert! plant
end
