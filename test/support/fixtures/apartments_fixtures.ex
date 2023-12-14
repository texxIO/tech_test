defmodule Ukio.ApartmentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ukio.Apartments` context.
  """

  @doc """
  Generate a apartment.
  """
  def apartment_fixture(attrs \\ %{}) do
    {:ok, apartment} =
      attrs
      |> Enum.into(%{
        address: "some address",
        monthly_price: 250_000,
        name: "some name",
        square_meters: 42,
        zip_code: "some zip_code",
        utility_rate: 0.0,
        market_id: 1
      })
      |> Ukio.Apartments.create_apartment()

    apartment
  end

  @doc """
  Generate a booking.
  """
  def booking_fixture(attrs \\ %{}) do
    apartment = apartment_fixture()

    {:ok, booking} =
      attrs
      |> Enum.into(%{
        apartment_id: apartment.id,
        check_in: ~D[2023-03-26],
        check_out: ~D[2023-03-26],
        deposit: 100_000,
        monthly_rent: apartment.monthly_price,
        utilities: 20000
      })
      |> Ukio.Apartments.create_booking()

    booking
  end
end
