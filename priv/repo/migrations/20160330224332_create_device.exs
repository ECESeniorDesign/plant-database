defmodule Backend.Repo.Migrations.CreateDevice do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :device_id, :string
      add :user_id, references(:users)

      timestamps
    end
    create index(:devices, [:user_id])
    create unique_index(:devices, [:device_id])

  end
end
