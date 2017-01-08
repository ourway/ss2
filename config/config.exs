# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :ss2, Ss2.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Q5q1/SpNuSq1jjniVVEuEdZ7LmLIBX/yAkhuzgAsIxfJD1mm5F1noHoigT9n3Gru",
  render_errors: [view: Ss2.ErrorView, accepts: ~w(json)],
  pubsub: [name: Ss2.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
