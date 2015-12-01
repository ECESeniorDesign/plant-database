defmodule Backend.Repo.Migrations.CreatePlants do
  use Ecto.Migration

  def change do
    create table(:plants) do
      add :name, :string
      add :photo_url, :string
      add :water_ideal, :float
      add :water_tolerance, :float
      add :light_ideal, :float
      add :light_tolerance, :float
      add :acidity_ideal, :float
      add :acidity_tolerance, :float
      add :humidity_ideal, :float
      add :humidity_tolerance, :float
      add :maturity, :integer
    
      timestamps
      
    end
  end
end
