defmodule Lager.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :acquired, :date
    field :residual_mass, :integer
    field :best_before, :date
    # field :product_id, :id
    belongs_to :product, Lager.Products.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:residual_mass, :acquired, :best_before, :product_id])
    |> validate_required([:residual_mass, :acquired, :best_before, :product_id])
  end
end
