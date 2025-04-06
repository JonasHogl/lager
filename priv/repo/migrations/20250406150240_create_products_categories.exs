defmodule Lager.Repo.Migrations.CreateProductsCategories do
  use Ecto.Migration

  def change do
    create table(:products_categories, primary_key: false) do
      add :product_id, references(:products, on_delete: :delete_all), primary_key: true
      add :category_id, references(:categories, on_delete: :delete_all), primary_key: true
    end

    create index(:products_categories, [:product_id])
    create index(:products_categories, [:category_id])
    # Ensures a product can't be associated with the same category twice
    create unique_index(:products_categories, [:product_id, :category_id])
  end
end
