defmodule Lager.Storage.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :amount, :integer
    field :total_price, :integer
    field :best_before, :date

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :amount, :total_price, :best_before])
    |> validate_required([:name, :amount, :total_price, :best_before])
  end
end
