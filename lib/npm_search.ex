defmodule NpmSearch do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    http_opts = Application.get_env(:npm_search, :http)

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, NpmSearch.Server, [], http_opts)
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NpmSearch.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
