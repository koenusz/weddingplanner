defmodule Weddingplanner.Repo.Migrations.CreateInvitation do
  use Ecto.Migration

  def change do
    create table(:invitations) do
      add :name, :string
      add :wedding, :string
      add :party, :string
      add :dinner, :string
      add :attending_wedding, :integer
      add :attending_party, :integer
      add :attending_dinner, :integer

      timestamps()
    end

  end
end
