defmodule Backend.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :encrypted_password, :string
      add :admin, :boolean, default: false

      timestamps
    end

  end
end
