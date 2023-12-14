defmodule UkioWeb.ApartmentController do
  use UkioWeb, :controller

  alias Ukio.Apartments

  action_fallback UkioWeb.FallbackController

  def index(conn, _params) do
    apartments = Apartments.list_apartments()
    render(conn, :index, apartments: apartments)
  end

  def show(conn, %{"id" => id}) do
    apartment = Apartments.get_apartment!(id)
    render(conn, :show, apartment: apartment)
  end
end
