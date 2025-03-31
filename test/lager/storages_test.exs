defmodule Lager.StoragesTest do
  use Lager.DataCase

  alias Lager.Storages

  describe "storages" do
    alias Lager.Storages.Storage

    import Lager.StoragesFixtures

    @invalid_attrs %{}

    test "list_storages/0 returns all storages" do
      storage = storage_fixture()
      assert Storages.list_storages() == [storage]
    end

    test "get_storage!/1 returns the storage with given id" do
      storage = storage_fixture()
      assert Storages.get_storage!(storage.id) == storage
    end

    test "create_storage/1 with valid data creates a storage" do
      valid_attrs = %{}

      assert {:ok, %Storage{} = storage} = Storages.create_storage(valid_attrs)
    end

    test "create_storage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Storages.create_storage(@invalid_attrs)
    end

    test "update_storage/2 with valid data updates the storage" do
      storage = storage_fixture()
      update_attrs = %{}

      assert {:ok, %Storage{} = storage} = Storages.update_storage(storage, update_attrs)
    end

    test "update_storage/2 with invalid data returns error changeset" do
      storage = storage_fixture()
      assert {:error, %Ecto.Changeset{}} = Storages.update_storage(storage, @invalid_attrs)
      assert storage == Storages.get_storage!(storage.id)
    end

    test "delete_storage/1 deletes the storage" do
      storage = storage_fixture()
      assert {:ok, %Storage{}} = Storages.delete_storage(storage)
      assert_raise Ecto.NoResultsError, fn -> Storages.get_storage!(storage.id) end
    end

    test "change_storage/1 returns a storage changeset" do
      storage = storage_fixture()
      assert %Ecto.Changeset{} = Storages.change_storage(storage)
    end
  end
end
