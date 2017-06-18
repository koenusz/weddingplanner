defmodule Weddingplanner.Repo.Migrations.CreateGinIndexForInvitations do
  use Ecto.Migration

  def change do
      execute """
        CREATE INDEX invitations_full_text_index
        ON invitations
        USING gin (
          to_tsvector(
            'english',
            name
          )
        );
      """
    end
  end
