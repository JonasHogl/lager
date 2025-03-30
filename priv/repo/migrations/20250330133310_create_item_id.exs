defmodule Lager.Repo.Migrations.CreateItemId do
  use Ecto.Migration

  def change do
    create table(:item_id) do
      add :name, :string
      add :amount, :integer
      add :cost, :integer
      add :best_before, :string

      timestamps(type: :utc_datetime)
    end
  end
end
