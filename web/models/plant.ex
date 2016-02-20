defmodule Backend.Plant do
  use Ecto.Model
  import Ecto.Query
  
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

  def compatible_with(query, plant_params) do
    do_compatible_with(query, plant_params)
  end

  def compatible_with(plant_params) do
    do_compatible_with(Backend.Plant, plant_params)
  end

  defp do_compatible_with(query, plant_params) do
    conditions = ["light", "water", "humidity", "temperature", "acidity"]
    Enum.reduce conditions, query, fn(condition, plants) ->
      ideal_field = String.to_atom(condition <> "_ideal")
      tolerance_field = String.to_atom(condition <> "_tolerance")
      ideal = plant_params[ideal_field]
      tolerance = plant_params[tolerance_field]
      from plant in plants,
        # Where their lower bound is less than our upper bound
        where: fragment("? - ? < ?", field(plant, ^ideal_field), field(plant, ^tolerance_field), ^(ideal + tolerance)),
        # Where their upper bound is greater than our lower bound
        where: fragment("? + ? > ?", field(plant, ^ideal_field), field(plant, ^tolerance_field), ^(ideal - tolerance))
    end
  end

end
