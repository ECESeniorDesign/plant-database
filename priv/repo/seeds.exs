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
    humidity_ideal: 72.0,
    humidity_tolerance: 7.0,
    temperature_ideal: 51.2,
    temperature_tolerance: 11.0,
    maturity: 85,
  },
  %Plant{
    name: "Onion",
    photo_url: "https://pbs.twimg.com/profile_images/595950387003166720/4BpRufhU.jpg",
    water_ideal: 35.0,
    water_tolerance: 5.0,
    light_ideal: 60.0,
    light_tolerance: 10.0,
    humidity_ideal: 42.0,
    humidity_tolerance: 27.0,
    temperature_ideal: 51.2,
    temperature_tolerance: 21.0,
    maturity: 185,
  },
  %Plant{
    name: "Lavender",
    photo_url: "http://images.agoramedia.com/everydayhealth/gcms/Lavender-Natural-oils-for-body-pg-full.jpg",
    water_ideal: 25.0,
    water_tolerance: 10.0,
    light_ideal: 50.0,
    light_tolerance: 10.0,
    humidity_ideal: 42.0,
    humidity_tolerance: 12.0,
    temperature_ideal: 55.2,
    temperature_tolerance: 1.0,
    maturity: 90,
  },
  %Plant{
    name: "Rosemary",
    photo_url: "http://img1.cookinglight.timeinc.net/sites/default/files/styles/400xvariable/public/image/2009/09/0909p70-rosemary-m.jpg?itok=VnPtQBxY",
    water_ideal: 55.0,
    water_tolerance: 20.0,
    light_ideal: 40.0,
    light_tolerance: 5.0,
    humidity_ideal: 42.0,
    humidity_tolerance: 17.0,
    temperature_ideal: 91.2,
    temperature_tolerance: 11.0,
    maturity: 15,
  },
]

admin = %Backend.User{
  username: "chase",
  encrypted_password: "$2b$12$esgSWxpgE/bt493UuMS3cuEiMVRv2.qBfTBtIXPCaJaLY2xrqP/r2",
  email: "cconkli4@u.rochester.edu",
  admin: true
}

admin = Repo.insert! admin
admin
  |> Ecto.Model.build(:notification_setting)
  |> Repo.insert!

for plant <- plants do
  Repo.insert! plant
end
