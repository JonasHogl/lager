defmodule Lager.Storages.Storage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "storages" do
    has_many :owners, Lager.Accounts.User
    has_many :items, Lager.Items.Item

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(storage, attrs) do
    storage
    |> cast(attrs, [])
    |> cast_assoc(:owners)
    |> cast_assoc(:items)
    |> validate_required([])
  end
end
