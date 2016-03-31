defmodule Backend.User do
  use Backend.Web, :model

  schema "users" do
    field :username, :string
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :admin, :boolean

    has_many :devices, Backend.Device
    has_one :notification_setting, Backend.NotificationSetting

    timestamps
  end

  @required_fields ~w(username email password password_confirmation)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:username, on: Backend.Repo, downcase: true)
    |> unique_constraint(:email, on: Backend.Repo, downcase: true)
    |> validate_length(:password, min: 1)
    |> validate_length(:password_confirmation, min: 1)
    |> validate_confirmation(:password)
  end

end
