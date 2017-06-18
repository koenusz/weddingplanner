defmodule Weddingplanner.Repo do
  use Ecto.Repo, otp_app: :weddingplanner

  use Scrivener, page_size: 25
end
