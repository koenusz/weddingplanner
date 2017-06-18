defmodule Weddingplanner.InvitationTest do
  use Weddingplanner.ModelCase

  alias Weddingplanner.Invitation

  @valid_attrs %{accepted_diner: true, accepted_party: true, accepted_wedding: true, attending_diner: 42, attending_party: 42, attending_wedding: 42, invited_diner: true, invited_party: true, invited_wedding: true, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Invitation.changeset(%Invitation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Invitation.changeset(%Invitation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
