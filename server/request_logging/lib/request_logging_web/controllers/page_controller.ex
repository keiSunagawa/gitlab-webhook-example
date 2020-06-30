defmodule RequestLoggingWeb.PageController do
  use RequestLoggingWeb, :controller

  def index(conn, _params) do
    IO.puts "========= get start ========"
    render(conn, "index.html")
  end
end
