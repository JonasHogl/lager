defmodule Lager.Repo.Migrations.CreateStorages do
  use Ecto.Migration

  def change do
    create table(:storages) do

      timestamps(type: :utc_datetime)
    end
  end
end
