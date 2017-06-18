defmodule Weddingplanner.InvitationView do
  use Weddingplanner.Web, :view

  def render("index.json", %{invitations: invitations}) do
  #  IO.puts("creating invitations view")
  #  IO.inspect(invitations)
    invitations
    # %{data: render_many(invitations, Weddingplanner.InvitationView, "invitation.json")}
  end

  def render("show.json", %{invitation: invitation}) do
     render_one(invitation, Weddingplanner.InvitationView, "invitation.json")
  end

  def render("invitation.json", %{invitation: invitation}) do
    invitation
  end

end
