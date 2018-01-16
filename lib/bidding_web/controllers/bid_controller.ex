defmodule BiddingWeb.BidController do
  use BiddingWeb, :controller

  alias Bidding.Primary
  alias Bidding.Primary.Bid

  def index(conn, _params) do
    bids = Primary.list_bids()
    render(conn, "index.html", bids: bids)
  end

  def new(conn, _params) do
    changeset = Primary.change_bid(%Bid{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bid" => bid_params}) do
    case Primary.create_bid(bid_params) do
      {:ok, bid} ->
        conn
        |> put_flash(:info, "Bid created successfully.")
        |> redirect(to: bid_path(conn, :show, bid))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bid = Primary.get_bid!(id)
    render(conn, "show.html", bid: bid)
  end

  def edit(conn, %{"id" => id}) do
    bid = Primary.get_bid!(id)
    changeset = Primary.change_bid(bid)
    render(conn, "edit.html", bid: bid, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bid" => bid_params}) do
    bid = Primary.get_bid!(id)

    case Primary.update_bid(bid, bid_params) do
      {:ok, bid} ->
        conn
        |> put_flash(:info, "Bid updated successfully.")
        |> redirect(to: bid_path(conn, :show, bid))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", bid: bid, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bid = Primary.get_bid!(id)
    {:ok, _bid} = Primary.delete_bid(bid)

    conn
    |> put_flash(:info, "Bid deleted successfully.")
    |> redirect(to: bid_path(conn, :index))
  end
end
