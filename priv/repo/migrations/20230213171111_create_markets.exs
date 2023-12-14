defmodule Ukio.Repo.Migrations.CreateMarkets do
  use Ecto.Migration

  def change do
    create table(:markets) do
      add :name, :string

      timestamps()
    end
  end
end
