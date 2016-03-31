defmodule Backend.Device do
  use Backend.Web, :model

  schema "devices" do
    field :device_id, :string
    belongs_to :user, Backend.User

    timestamps
  end

  @required_fields ~w(device_id user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:device_id)
  end
end
