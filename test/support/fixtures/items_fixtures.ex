defmodule Lager.ItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lager.Items` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        acquired: ~D[2025-03-30],
        best_before: ~D[2025-03-30],
        residual_mass: 42
      })
      |> Lager.Items.create_item()

    item
  end
end
