defmodule UkioWeb.BookingController do
  use UkioWeb, :controller

  alias Ukio.Apartments

  alias Ukio.Bookings.Handlers.BookingCreator

  alias UkioWeb.ErrorJSON

  action_fallback UkioWeb.FallbackController

  def create(conn, %{"booking" => booking_params}) do
    case BookingCreator.create(booking_params) do
      {:ok, booking} ->
        conn
        |> put_status(:created)
        |> render("show.json", booking: booking)

      {:error, status, reason} ->
        conn
        |> put_status(status)
        |> put_view(ErrorJSON)
        |> render("error.json", reason: reason)
    end
  end

  def show(conn, %{"id" => id}) do
    booking = Apartments.get_booking!(id)
    render(conn, :show, booking: booking)
  end
end
