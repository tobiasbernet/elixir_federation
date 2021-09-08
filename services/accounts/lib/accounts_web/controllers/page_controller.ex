defmodule AccountsWeb.PageController do
  use AccountsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
