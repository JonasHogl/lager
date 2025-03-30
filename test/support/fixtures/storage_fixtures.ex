defmodule Lager.StorageFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lager.Storage` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        amount: 42,
        name: "some name",
        total_price: 42
      })
      |> Lager.Storage.create_item()

    item
  end
end
