defmodule BiddingWeb.BidControllerTest do
  use BiddingWeb.ConnCase

  alias Bidding.Primary

  @create_attrs %{ending: ~N[2010-04-17 14:00:00.000000], price: "120.5", product_id: 42, starting: ~N[2010-04-17 14:00:00.000000], winner: "some winner"}
  @update_attrs %{ending: ~N[2011-05-18 15:01:01.000000], price: "456.7", product_id: 43, starting: ~N[2011-05-18 15:01:01.000000], winner: "some updated winner"}
  @invalid_attrs %{ending: nil, price: nil, product_id: nil, starting: nil, winner: nil}

  def fixture(:bid) do
    {:ok, bid} = Primary.create_bid(@create_attrs)
    bid
  end

  describe "index" do
    test "lists all bids", %{conn: conn} do
      conn = get conn, bid_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Bids"
    end
  end

  describe "new bid" do
    test "renders form", %{conn: conn} do
      conn = get conn, bid_path(conn, :new)
      assert html_response(conn, 200) =~ "New Bid"
    end
  end

  describe "create bid" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, bid_path(conn, :create), bid: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == bid_path(conn, :show, id)

      conn = get conn, bid_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Bid"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, bid_path(conn, :create), bid: @invalid_attrs
      assert html_response(conn, 200) =~ "New Bid"
    end
  end

  describe "edit bid" do
    setup [:create_bid]

    test "renders form for editing chosen bid", %{conn: conn, bid: bid} do
      conn = get conn, bid_path(conn, :edit, bid)
      assert html_response(conn, 200) =~ "Edit Bid"
    end
  end

  describe "update bid" do
    setup [:create_bid]

    test "redirects when data is valid", %{conn: conn, bid: bid} do
      conn = put conn, bid_path(conn, :update, bid), bid: @update_attrs
      assert redirected_to(conn) == bid_path(conn, :show, bid)

      conn = get conn, bid_path(conn, :show, bid)
      assert html_response(conn, 200) =~ "some updated winner"
    end

    test "renders errors when data is invalid", %{conn: conn, bid: bid} do
      conn = put conn, bid_path(conn, :update, bid), bid: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Bid"
    end
  end

  describe "delete bid" do
    setup [:create_bid]

    test "deletes chosen bid", %{conn: conn, bid: bid} do
      conn = delete conn, bid_path(conn, :delete, bid)
      assert redirected_to(conn) == bid_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, bid_path(conn, :show, bid)
      end
    end
  end

  defp create_bid(_) do
    bid = fixture(:bid)
    {:ok, bid: bid}
  end
end
