defmodule Bidding.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :product_name, :string
      add :image, :string
      add :category, :string
      add :quantity, :integer

      timestamps()
    end

  end
end
