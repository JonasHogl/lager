defmodule Lager.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :net_mass, :integer
    field :cost, :float
    # has_many :categories, Lager.Categories.Category
    many_to_many :categories, Lager.Categories.Category,
      join_through: "product_categories",
      on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :net_mass, :cost, :category_id])
    |> validate_required([:name, :net_mass, :cost])
    |> put_assoc(:categories, attrs.categories || [])
  end
end
