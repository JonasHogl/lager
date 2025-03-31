defmodule Lager.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :amount, :integer
      add :total_price, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
