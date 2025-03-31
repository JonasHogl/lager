defmodule Lager.StoragesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lager.Storages` context.
  """

  @doc """
  Generate a storage.
  """
  def storage_fixture(attrs \\ %{}) do
    {:ok, storage} =
      attrs
      |> Enum.into(%{

      })
      |> Lager.Storages.create_storage()

    storage
  end
end
