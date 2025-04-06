defmodule Lager.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :name, :string
    field :description, :string

    many_to_many :products, Lager.Products.Product,
      join_through: "products_categories",
      on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
    |> put_assoc(:products, attrs[:products] || [])
  end
end
