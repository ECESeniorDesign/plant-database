defmodule Backend.Repo.Migrations.CreateNotificationSetting do
  use Ecto.Migration

  def change do
    create table(:notification_settings) do
      add :email, :boolean, default: false
      add :push, :boolean, default: false
      add :user_id, references(:users)

      timestamps
    end
    create index(:notification_settings, [:user_id])

  end
end
