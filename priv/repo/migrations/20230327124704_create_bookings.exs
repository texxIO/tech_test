defmodule Ukio.Repo.Migrations.CreateBookings do
  use Ecto.Migration

  def change do
    create table(:bookings) do
      add :check_in, :date
      add :check_out, :date
      add :apartment_id, references(:apartments, on_delete: :delete_all), null: false
      add :monthly_rent, :integer
      add :deposit, :integer
      add :utilities, :float

      timestamps()
    end
  end
end
