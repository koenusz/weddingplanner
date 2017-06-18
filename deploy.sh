# Initial setup
mix release.clean
mix deps.get --only prod
MIX_ENV=prod mix compile


# Compile assets

MIX_ENV=prod mix phoenix.digest



# Custom tasks (like DB migrations)
MIX_ENV=prod mix ecto.migrate

# compile and release
MIX_ENV=prod mix compile
MIX_ENV=prod mix release

# Finally run the server
PORT=4001 MIX_ENV=prod mix phoenix.server
