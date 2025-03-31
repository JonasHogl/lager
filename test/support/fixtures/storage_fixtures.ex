defmodule Lager.StorageFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lager.Storage` context.
  """

  @doc """
  Generate a items.
  """
  def items_fixture(attrs \\ %{}) do
    {:ok, items} =
      attrs
      |> Enum.into(%{
        amount: 42,
        best_before: "some best_before",
        cost: 42,
        name: "some name"
      })
      |> Lager.Storage.create_items()

    items
  end
end
