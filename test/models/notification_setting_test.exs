defmodule Backend.NotificationSettingTest do
  use Backend.ModelCase

  alias Backend.NotificationSetting

  @valid_attrs %{email: true, push: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = NotificationSetting.changeset(%NotificationSetting{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = NotificationSetting.changeset(%NotificationSetting{}, @invalid_attrs)
    refute changeset.valid?
  end
end
