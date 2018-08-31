use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tak, Tak.Endpoint,
  http: [port: 4001],
  server: false

config :tak,
  bucket_type: "maps",
  bucket_name: "tak_users"

# Print only warnings and errors during test
config :logger, level: :warn

config :pooler,
  pools: [
    [
      name: :riaklocal1,
      group: :riak,
      max_count: 20,
      init_count: 10,
      start_mfa: {Riak.Connection, :start_link, ['127.0.0.1', 8087]}
    ]
  ]
