defmodule Backend.DeviceTest do
  use Backend.ModelCase

  alias Backend.Device

  @valid_attrs %{device_id: "some content", user_id: 5}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Device.changeset(%Device{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Device.changeset(%Device{}, @invalid_attrs)
    refute changeset.valid?
  end
end
