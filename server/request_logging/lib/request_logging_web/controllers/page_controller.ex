defmodule RequestLoggingWeb.PageController do
  use RequestLoggingWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
