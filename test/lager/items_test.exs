defmodule Lager.ItemsTest do
  use Lager.DataCase

  alias Lager.Items

  describe "items" do
    alias Lager.Items.Item

    import Lager.ItemsFixtures

    @invalid_attrs %{acquired: nil, residual_mass: nil, best_before: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Items.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Items.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{acquired: ~D[2025-04-05], residual_mass: 42, best_before: ~D[2025-04-05]}

      assert {:ok, %Item{} = item} = Items.create_item(valid_attrs)
      assert item.acquired == ~D[2025-04-05]
      assert item.residual_mass == 42
      assert item.best_before == ~D[2025-04-05]
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{acquired: ~D[2025-04-06], residual_mass: 43, best_before: ~D[2025-04-06]}

      assert {:ok, %Item{} = item} = Items.update_item(item, update_attrs)
      assert item.acquired == ~D[2025-04-06]
      assert item.residual_mass == 43
      assert item.best_before == ~D[2025-04-06]
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_item(item, @invalid_attrs)
      assert item == Items.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Items.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Items.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Items.change_item(item)
    end
  end
end
