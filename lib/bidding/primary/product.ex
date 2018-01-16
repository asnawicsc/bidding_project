defmodule Bidding.Primary.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bidding.Primary.Product


  schema "products" do
    field :category, :string
    field :image, :string
    field :product_name, :string
    field :quantity, :integer

    timestamps()
  end

  @doc false
  def changeset(%Product{} = product, attrs) do
    product
    |> cast(attrs, [:product_name, :image, :category, :quantity])
    |> validate_required([:product_name, :image, :category, :quantity])
  end
end
