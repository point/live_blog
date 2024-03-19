import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :live_blog, LiveBlogWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "8wo2vWY6jspE5VVKkkS8Ts8WP09rgi4hB96ljnMqbJfpqfe0t2lu4HEWSsaOHdXh",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
