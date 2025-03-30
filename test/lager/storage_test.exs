defmodule Lager.StorageTest do
  use Lager.DataCase

  alias Lager.Storage

  describe "items" do
    alias Lager.Storage.Item

    import Lager.StorageFixtures

    @invalid_attrs %{name: nil, amount: nil, total_price: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Storage.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Storage.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{name: "some name", amount: 42, total_price: 42}

      assert {:ok, %Item{} = item} = Storage.create_item(valid_attrs)
      assert item.name == "some name"
      assert item.amount == 42
      assert item.total_price == 42
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Storage.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{name: "some updated name", amount: 43, total_price: 43}

      assert {:ok, %Item{} = item} = Storage.update_item(item, update_attrs)
      assert item.name == "some updated name"
      assert item.amount == 43
      assert item.total_price == 43
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Storage.update_item(item, @invalid_attrs)
      assert item == Storage.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Storage.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Storage.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Storage.change_item(item)
    end
  end
end
