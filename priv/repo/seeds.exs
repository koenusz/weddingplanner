# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Weddingplanner.Repo.insert!(%Weddingplanner.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Weddingplanner.{Repo, Invitation}


for index <- 1..100 do
  name = FakerElixir.Name.name

  weddingstatus = Enum.random Invitation.status
  partystatus = Enum.random Invitation.status
  dinnerstatus = Enum.random Invitation.status


params = %{
  name: name,
  wedding: weddingstatus,
  party: partystatus,
  dinner: dinnerstatus,
  attending_wedding: FakerElixir.Number.between(1..10),
  attending_party: FakerElixir.Number.between(1..10),
  attending_dinner: FakerElixir.Number.between(1..10)
}

{:ok, invitation} = %Invitation{}
  |> Invitation.changeset(params)
  |> Repo.insert

IO.puts "---- Inserted number #{index} invitation #{invitation.id}"

end
