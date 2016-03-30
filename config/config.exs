# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :backend, Backend.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "RV/KDlyAHn2s8ReguZJ+ModQ/wvj8NORUSZUUjbfsyPYSJtDdfmQ7uYbySjNi0mB",
  render_errors: [accepts: ~w(html json)],
  mailgun_domain: "https://api.mailgun.net/v3/sandbox0554392105884a0b8c41e3b610d97268.mailgun.org",
  # Change for production
  mailgun_key: "key-a4acb1ea1569cda49e36301e79dc81e9",
  pubsub: [name: Backend.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :phoenix, :filter_parameters, ["password", "token"]

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :apns,
  # Here goes "global" config applied as default to all pools started if not overwritten by pool-specific value
  callback_module:    APNS.Callback,
  timeout:            30,
  feedback_interval:  1200,
  reconnect_after:    1000,
  support_old_ios:    true,
  # Here are pools configs. Any value from "global" config can be overwritten in any single pool config
  pools: [
    # app1_dev_pool is the pool_name
    app1_dev_pool: [
      env: :dev,
      pool_size: 10,
      pool_max_overflow: 5,
      # and this is overwritten config key
      certfile: "/Users/chase/Drive/greenhouse/cert.pem"
    ]
  ]
