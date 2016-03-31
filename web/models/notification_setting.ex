defmodule Backend.NotificationSetting do
  use Backend.Web, :model

  schema "notification_settings" do
    field :email, :boolean, default: false
    field :push, :boolean, default: false
    belongs_to :user, Backend.User

    timestamps
  end

  @required_fields ~w(email push)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
