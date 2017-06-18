defmodule Weddingplanner.InvitationController do
  use Weddingplanner.Web, :controller

  alias Weddingplanner.Invitation

  def index(conn, params) do
    search = Map.get(params, "search", "")

    invitations = Invitation
      |> Invitation.search(search)
      |> order_by(:name)
      |> Repo.paginate(params)
    render(conn, "index.json", invitations: invitations)
  end

  def create(conn, %{"invitation" => invitation_params}) do
    changeset = Invitation.changeset(%Invitation{}, invitation_params)

    case Repo.insert(changeset) do
      {:ok, invitation} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", invitation_path(conn, :show, invitation))
        |> render("show.json", invitation: invitation)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Weddingplanner.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    invitation = Repo.get!(Invitation, id)
    render(conn, "show.json", invitation: invitation)
  end



  def update(conn, %{"id" => id, "invitation" => invitation_params}) do
    invitation = Repo.get!(Invitation, id)
    changeset = Invitation.changeset(invitation, invitation_params)

    case Repo.update(changeset) do
      {:ok, invitation} ->
        render(conn, "show.json", invitation: invitation)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Weddingplanner.ChangesetView, "error.json", changeset: changeset)
    end
  end


  def delete(conn, %{"id" => id}) do
    invitation = Repo.get!(Invitation, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(invitation)

    send_resp(conn, :no_content, "")
  end
end
