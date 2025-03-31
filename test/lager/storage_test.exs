defmodule Lager.StorageTest do
  use Lager.DataCase

  alias Lager.Storage

  describe "item_id" do
    alias Lager.Storage.Items

    import Lager.StorageFixtures

    @invalid_attrs %{name: nil, amount: nil, cost: nil, best_before: nil}

    test "list_item_id/0 returns all item_id" do
      items = items_fixture()
      assert Storage.list_item_id() == [items]
    end

    test "get_items!/1 returns the items with given id" do
      items = items_fixture()
      assert Storage.get_items!(items.id) == items
    end

    test "create_items/1 with valid data creates a items" do
      valid_attrs = %{name: "some name", amount: 42, cost: 42, best_before: "some best_before"}

      assert {:ok, %Items{} = items} = Storage.create_items(valid_attrs)
      assert items.name == "some name"
      assert items.amount == 42
      assert items.cost == 42
      assert items.best_before == "some best_before"
    end

    test "create_items/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Storage.create_items(@invalid_attrs)
    end

    test "update_items/2 with valid data updates the items" do
      items = items_fixture()
      update_attrs = %{name: "some updated name", amount: 43, cost: 43, best_before: "some updated best_before"}

      assert {:ok, %Items{} = items} = Storage.update_items(items, update_attrs)
      assert items.name == "some updated name"
      assert items.amount == 43
      assert items.cost == 43
      assert items.best_before == "some updated best_before"
    end

    test "update_items/2 with invalid data returns error changeset" do
      items = items_fixture()
      assert {:error, %Ecto.Changeset{}} = Storage.update_items(items, @invalid_attrs)
      assert items == Storage.get_items!(items.id)
    end

    test "delete_items/1 deletes the items" do
      items = items_fixture()
      assert {:ok, %Items{}} = Storage.delete_items(items)
      assert_raise Ecto.NoResultsError, fn -> Storage.get_items!(items.id) end
    end

    test "change_items/1 returns a items changeset" do
      items = items_fixture()
      assert %Ecto.Changeset{} = Storage.change_items(items)
    end
  end
end
