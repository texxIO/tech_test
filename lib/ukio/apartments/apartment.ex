defmodule Ukio.Apartments.Apartment do
  alias Ukio.Bookings.Booking
  alias Ukio.Markets.Market
  use Ecto.Schema
  import Ecto.Changeset

  schema "apartments" do
    field :address, :string
    field :monthly_price, :integer
    field :name, :string
    field :square_meters, :integer
    field :zip_code, :string
    field :utility_rate, :float
    has_many :bookings, Booking
    belongs_to :market, Market
    timestamps()
  end

  @doc false
  def changeset(apartment, attrs) do
    apartment
    |> cast(attrs, [:name, :address, :zip_code, :monthly_price, :square_meters, :market_id, :utility_rate])
    |> validate_required([:name, :address, :zip_code, :monthly_price, :square_meters, :market_id])
  end
end
