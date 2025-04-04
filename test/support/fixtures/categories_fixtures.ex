defmodule Lager.CategoriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lager.Categories` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> Lager.Categories.create_category()

    category
  end
end
