defmodule NpmSearch.Server do
  use Plug.Router

  @base_url "https://registry.npmjs.org/"

  plug Corsica, origins: "*"
  plug :match
  plug :dispatch

  get "/:name" do
    {code, response} = find_package(name)
    conn
    |> put_resp_header("Content-Type", "application/json")
    |> send_resp(code, response)
  end

  defp find_package(name) do
    url = Path.join(@base_url, name)
    case HTTPoison.get!(url) do
      %HTTPoison.Response{status_code: 200, body: body} ->
        {200, body}
      %HTTPoison.Response{status_code: 404} ->
        {404, Poison.encode!(%{"error" => "package #{name} does not exist"})}
      _ ->
        {500, Poison.encode!(%{"error" => "an error occured"})}
    end
  end
end
