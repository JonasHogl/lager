defmodule Lager.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :residual_mass, :integer
      add :acquired, :date
      add :best_before, :date
      add :product_id, references(:products, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:items, [:product_id])
  end
end
