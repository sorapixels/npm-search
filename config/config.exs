use Mix.Config

config :npm_search, :http,
  port: String.to_integer(System.get_env("PORT") || "4000")
