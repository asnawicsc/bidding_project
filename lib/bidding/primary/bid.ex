defmodule Bidding.Primary.Bid do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bidding.Primary.Bid


  schema "bids" do
    field :ending, :naive_datetime
    field :price, :decimal
    field :product_id, :integer
    field :starting, :naive_datetime
    field :winner, :string

    timestamps()
  end

  @doc false
  def changeset(%Bid{} = bid, attrs) do
    bid
    |> cast(attrs, [:product_id, :price, :starting, :ending, :winner])
    |> validate_required([:product_id, :price, :starting, :ending, :winner])
  end
end
