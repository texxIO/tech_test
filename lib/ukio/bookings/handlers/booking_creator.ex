defmodule Ukio.Bookings.Handlers.BookingCreator do
  alias Ukio.Apartments
  alias Ukio.Markets.MarketConditions
  require Logger

  def create(
        %{"check_in" => check_in, "check_out" => check_out, "apartment_id" => apartment_id} =
          _params
      ) do
    try do
      {:ok, check_in_date} = to_date(check_in)
      {:ok, check_out_date} = to_date(check_out)

      with apartment = Ukio.Apartments.get_apartment!(apartment_id),
           {:ok, :valid} <- validate_booking_dates(check_in_date, check_out_date),
           {:ok, :available} <-
             validate_availability(apartment_id, check_in_date, check_out_date),
           booking_data = generate_booking_data(apartment, check_in_date, check_out_date),
           {:ok, booking} <- Ukio.Apartments.create_booking(booking_data) do
        {:ok, booking}
      else
        {:error, :unavailable} ->
          {:error, :unauthorized, "Apartment not available for the specified dates"}

        {:error, :invalid} ->
          {:error, :unprocessable_entity, "Invalid booking dates"}

        {:error, reason} ->
          {:error, :unprocessable_entity, reason}
      end
    rescue
      Ecto.NoResultsError ->
        {:error, :unprocessable_entity, "Apartment not found"}

      MatchError ->
        {:error, :unprocessable_entity, "Invalid booking dates"}

      exception ->
        Logger.error("An unexpected error occurred: #{exception.message}")
        {:error, :unprocessable_entity, "An unexpected error occurred #{exception}"}
    end
  end

  defp generate_booking_data(apartment, check_in, check_out) do

    market_conditions = MarketConditions.get_conditions(apartment)
    booking_data = %{
      apartment_id: apartment.id,
      check_in: check_in,
      check_out: check_out,
      monthly_rent: apartment.monthly_price
    }

    Map.merge(booking_data, market_conditions)
  end

  defp validate_availability(apartment_id, check_in, check_out) do
    case Apartments.check_availability(apartment_id, check_in, check_out) do
      {:ok, true} ->
        {:ok, :available}

      {:ok, false} ->
        {:error, :unavailable}
    end
  end

  # Validates that the check in and check out dates are valid.
  # - Check in or check out can't be in the past
  # - Check in must be before check out
  # - Check in and check out can't be the same date

  defp validate_booking_dates(check_in, check_out) do
    today = Date.utc_today()

    case {check_in, check_out} do
      {%Date{} = valid_check_in_date, %Date{} = valid_check_out_date} ->
        case Date.compare(valid_check_in_date, valid_check_out_date) do
          :lt ->
            case Date.compare(valid_check_in_date, today) do
              :lt ->
                {:error, :invalid}

              _ ->
                case Date.compare(valid_check_out_date, today) do
                  :lt ->
                    {:error, :invalid}

                  _ ->
                    {:ok, :valid}
                end
            end

          _ ->
            {:error, :invalid}
        end

      _ ->
        {:error, :invalid}
    end
  end

  # Make sure we are working with Date structs, if not try to convert the dates

  defp to_date(date) when is_binary(date) do
    case Date.from_iso8601(date) do
      {:ok, result} ->
        {:ok, result}

      _ ->
        {:error, :invalid}
    end
  end

  defp to_date(date) do
    {:ok, date}
  end
end
