defmodule BiddingWeb.PageController do
  use BiddingWeb, :controller

  def index(conn, _params) do
  	IO.puts "this has happened"
    render(conn, "index.html")
  end

end
