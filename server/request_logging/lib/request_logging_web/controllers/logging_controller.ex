defmodule RequestLoggingWeb.LoggingController do
  use RequestLoggingWeb, :controller

  def create(conn, params) do
    IO.puts "========= logging start ========"
    IO.inspect conn
    IO.inspect params
    IO.puts "========= logging end   ========"
    json(conn, %{id: "a"})
  end
end
