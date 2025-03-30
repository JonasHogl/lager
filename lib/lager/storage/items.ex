defmodule Lager.Storage.Items do
  use Ecto.Schema
  import Ecto.Changeset

  schema "item_id" do
    field :name, :string
    field :amount, :integer
    field :cost, :integer
    field :best_before, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(items, attrs) do
    items
    |> cast(attrs, [:name, :amount, :cost, :best_before])
    |> validate_required([:name, :amount, :cost, :best_before])
  end
end
