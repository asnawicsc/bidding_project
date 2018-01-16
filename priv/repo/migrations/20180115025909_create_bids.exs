defmodule Bidding.Repo.Migrations.CreateBids do
  use Ecto.Migration

  def change do
    create table(:bids) do
      add :product_id, :integer
      add :price, :decimal
      add :starting, :naive_datetime
      add :ending, :naive_datetime
      add :winner, :string

      timestamps()
    end

  end
end
