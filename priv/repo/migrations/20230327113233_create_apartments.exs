defmodule Ukio.Repo.Migrations.CreateApartments do
  use Ecto.Migration

  def change do
    create table(:apartments) do
      add :name, :string
      add :address, :string
      add :zip_code, :string
      add :monthly_price, :integer
      add :square_meters, :integer
      add :utility_rate, :float, default: 0.0
      add :market_id, :integer, default: 1


      timestamps()
    end
  end
end
