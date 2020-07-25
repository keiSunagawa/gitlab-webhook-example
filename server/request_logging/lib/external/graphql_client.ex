defmodule External.GraphqlClient do
  use GenServer

  @endpoint "http://gilab-service/api/graphql"
  @token "hM79LVge7BDx8xfyzNWb"

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:query, q}, _from, state) do
    %HTTPoison.Response{status_code: 200, body: body}  = HTTPoison.post!(
      @endpoint,
      Jason.encode!(%{"query" => q, "variables" => nil}),
      [
        {"Content-Type", "application/json"},
        {"Private-Token", @token}
      ]
    )
    {:reply, Jason.decode!(body), state}
  end

  def query(q), do: GenServer.call(__MODULE__, {:query, q})
end

defmodule GQLTest do
  def f() do
    q = """
    query {
      project(fullPath:"root/foo") {
        fullPath
      }
    }
    """
    External.GraphqlClient.query(q)
  end
end
