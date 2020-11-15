defmodule DealSignalWeb.PageController do
  use DealSignalWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
