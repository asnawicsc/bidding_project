defmodule Bidding.PrimaryTest do
  use Bidding.DataCase

  alias Bidding.Primary

  describe "bids" do
    alias Bidding.Primary.Bid

    @valid_attrs %{ending: ~N[2010-04-17 14:00:00.000000], price: "120.5", product_id: 42, starting: ~N[2010-04-17 14:00:00.000000], winner: "some winner"}
    @update_attrs %{ending: ~N[2011-05-18 15:01:01.000000], price: "456.7", product_id: 43, starting: ~N[2011-05-18 15:01:01.000000], winner: "some updated winner"}
    @invalid_attrs %{ending: nil, price: nil, product_id: nil, starting: nil, winner: nil}

    def bid_fixture(attrs \\ %{}) do
      {:ok, bid} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Primary.create_bid()

      bid
    end

    test "list_bids/0 returns all bids" do
      bid = bid_fixture()
      assert Primary.list_bids() == [bid]
    end

    test "get_bid!/1 returns the bid with given id" do
      bid = bid_fixture()
      assert Primary.get_bid!(bid.id) == bid
    end

    test "create_bid/1 with valid data creates a bid" do
      assert {:ok, %Bid{} = bid} = Primary.create_bid(@valid_attrs)
      assert bid.ending == ~N[2010-04-17 14:00:00.000000]
      assert bid.price == Decimal.new("120.5")
      assert bid.product_id == 42
      assert bid.starting == ~N[2010-04-17 14:00:00.000000]
      assert bid.winner == "some winner"
    end

    test "create_bid/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Primary.create_bid(@invalid_attrs)
    end

    test "update_bid/2 with valid data updates the bid" do
      bid = bid_fixture()
      assert {:ok, bid} = Primary.update_bid(bid, @update_attrs)
      assert %Bid{} = bid
      assert bid.ending == ~N[2011-05-18 15:01:01.000000]
      assert bid.price == Decimal.new("456.7")
      assert bid.product_id == 43
      assert bid.starting == ~N[2011-05-18 15:01:01.000000]
      assert bid.winner == "some updated winner"
    end

    test "update_bid/2 with invalid data returns error changeset" do
      bid = bid_fixture()
      assert {:error, %Ecto.Changeset{}} = Primary.update_bid(bid, @invalid_attrs)
      assert bid == Primary.get_bid!(bid.id)
    end

    test "delete_bid/1 deletes the bid" do
      bid = bid_fixture()
      assert {:ok, %Bid{}} = Primary.delete_bid(bid)
      assert_raise Ecto.NoResultsError, fn -> Primary.get_bid!(bid.id) end
    end

    test "change_bid/1 returns a bid changeset" do
      bid = bid_fixture()
      assert %Ecto.Changeset{} = Primary.change_bid(bid)
    end
  end

  describe "products" do
    alias Bidding.Primary.Product

    @valid_attrs %{category: "some category", image: "some image", product_name: "some product_name", quantity: 42}
    @update_attrs %{category: "some updated category", image: "some updated image", product_name: "some updated product_name", quantity: 43}
    @invalid_attrs %{category: nil, image: nil, product_name: nil, quantity: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Primary.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Primary.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Primary.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Primary.create_product(@valid_attrs)
      assert product.category == "some category"
      assert product.image == "some image"
      assert product.product_name == "some product_name"
      assert product.quantity == 42
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Primary.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, product} = Primary.update_product(product, @update_attrs)
      assert %Product{} = product
      assert product.category == "some updated category"
      assert product.image == "some updated image"
      assert product.product_name == "some updated product_name"
      assert product.quantity == 43
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Primary.update_product(product, @invalid_attrs)
      assert product == Primary.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Primary.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Primary.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Primary.change_product(product)
    end
  end
end
