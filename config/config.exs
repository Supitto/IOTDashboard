# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dashboard,
  ecto_repos: [Dashboard.Repo]

config :dashboard, Dashboard.Auth.Guardian,
  issuer: "dashboard", # Name of your app/company/product
  secret_key: "fyq2C0mWuBxGLCK6+LEoItNfyeE4SONLXbkdTwLoZUETrL5CDulp6Uyv7x55KkEc" # Replace this with the output of the mix command

config :dashboard, DashboardWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bZbW9LQ+RqHqh3cqTWTJp5MCevIRm/UBkMX/yW+3wRJOSE0XFsShvrXYT1/ozpPl",
  render_errors: [view: DashboardWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Dashboard.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
