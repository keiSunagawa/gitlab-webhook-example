defmodule RequestLoggingWeb.LoggingController do
  use RequestLoggingWeb, :controller

  def create(conn, params) do
    # IO.puts "========= logging start ========"
    # conn.body_params
    # IO.inspect params
    # IO.puts "========= logging end   ========"
    GithubHook.HookList.event_hook(params)
    json(conn, %{id: "a"})
  end
end
