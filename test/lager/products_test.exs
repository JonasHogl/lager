defmodule Lager.ProductsTest do
  use Lager.DataCase

  alias Lager.Products

  describe "products" do
    alias Lager.Products.Product

    import Lager.ProductsFixtures

    @invalid_attrs %{name: nil, net_mass: nil, cost: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{name: "some name", net_mass: 42, cost: 120.5}

      assert {:ok, %Product{} = product} = Products.create_product(valid_attrs)
      assert product.name == "some name"
      assert product.net_mass == 42
      assert product.cost == 120.5
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{name: "some updated name", net_mass: 43, cost: 456.7}

      assert {:ok, %Product{} = product} = Products.update_product(product, update_attrs)
      assert product.name == "some updated name"
      assert product.net_mass == 43
      assert product.cost == 456.7
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end
end
