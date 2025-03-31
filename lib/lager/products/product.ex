defmodule Lager.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :mass, :integer
    field :cost, :float
    has_many :categories, Lager.Categories.Category

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :mass, :cost])
    |> cast_assoc(:categories)
    |> validate_required([:name, :mass, :cost])
  end
end
