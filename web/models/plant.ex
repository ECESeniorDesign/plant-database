defmodule Backend.Plant do
  use Ecto.Model
  
  schema "plants" do
    field :name
    field :photo_url
    field :water_ideal, :float
    field :water_tolerance, :float
    field :light_ideal, :float
    field :light_tolerance, :float
    field :acidity_ideal, :float
    field :acidity_tolerance, :float
    field :humidity_ideal, :float
    field :humidity_tolerance, :float
    field :temperature_ideal, :float
    field :temperature_tolerance, :float
    field :maturity, :integer
    
    timestamps
    
  end
end