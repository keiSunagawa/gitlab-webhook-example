defmodule External.GraphqlClient do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:query, q}, _from, state) do
    x = HTTPoison.post(
      "http://localhost:31102/api/graphql",
      Jason.encode!(%{"query" => q, "variables" => nil}),
      [
        {"Content-Type", "application/json"},
        {"Private-Token", "hM79LVge7BDx8xfyzNWb"}
      ]
    )
    IO.inspect x
    {:reply, "test", state}
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
