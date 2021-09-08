defmodule ReviewsWeb.PageController do
  use ReviewsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
