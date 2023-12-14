defmodule Ukio.Bookings.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ukio.Apartments.Apartment

  schema "bookings" do
    belongs_to(:apartment, Apartment)

    field :check_in, :date
    field :check_out, :date
    field :deposit, :integer
    field :monthly_rent, :integer
    field :utilities, :float

    timestamps()
  end

  @spec changeset(
          {map(), map()}
          | %{
              :__struct__ => atom() | %{:__changeset__ => map(), optional(any()) => any()},
              optional(atom()) => any()
            },
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:check_in, :check_out, :apartment_id, :monthly_rent, :deposit, :utilities])
    |> validate_required([
      :check_in,
      :check_out,
      :apartment_id,
      :monthly_rent,
      :deposit,
      :utilities
    ])
  end
end
