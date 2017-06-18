defmodule Weddingplanner.Invitation do
  use Weddingplanner.Web, :model

@derive {Poison.Encoder, except: [:__meta__]}

@status [
  "NotInvited",
  "Invited",
  "Accepted",
  "Declined"
]

  schema "invitations" do
    field :name, :string
    field :wedding, :string, default: "NotInvited"
    field :party, :string, default: "NotInvited"
    field :dinner, :string, default: "NotInvited"
    field :attending_wedding, :integer
    field :attending_party, :integer
    field :attending_dinner, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :wedding, :party, :dinner, :attending_wedding, :attending_party, :attending_dinner])
    |> validate_required([:name, :wedding, :party, :dinner, :attending_wedding, :attending_party, :attending_dinner])
  end

  @doc """
  Returns status options
  """
  def status, do: @status

  def search(query, ""), do: query
  def search(query, search_query) do
    search_query = ts_query_format(search_query)

    query
    |> where(
      fragment(
      """
      (to_tsvector(
        'english',
        coalesce(name, '') )
        @@ to_tsquery('english', ?))
      """,
      ^search_query
      )
    )
  end

  defp ts_query_format(search_query) do
    search_query
    |> String.trim
    |> String.split(" ")
    |> Enum.map(&("#{&1}:*"))
    |> Enum.join(" & ")
  end
end
