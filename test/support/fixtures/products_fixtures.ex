defmodule Lager.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lager.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        cost: 120.5,
        mass: 42,
        name: "some name"
      })
      |> Lager.Products.create_product()

    product
  end
end
