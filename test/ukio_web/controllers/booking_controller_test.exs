defmodule UkioWeb.BookingControllerTest do
  use UkioWeb.ConnCase, async: true

  import Ukio.ApartmentsFixtures

  valid_check_in_date = Date.add(Date.utc_today(), 1) |> Date.to_string()
  valid_check_out_date = Date.add(Date.utc_today(), 2) |> Date.to_string()

  @create_attrs %{
    apartment_id: 42,
    check_in: valid_check_in_date,
    check_out: valid_check_out_date
  }

  @invalid_attrs %{
    apartment_id: 1,
    check_in: nil,
    check_out: nil,
    deposit: nil,
    monthly_rent: nil,
    utilities: nil
  }

  setup %{conn: conn} do
    {:ok,
     conn: put_req_header(conn, "accept", "application/json"), apartment: apartment_fixture()}
  end

  describe "create booking" do
    test "renders booking when data is valid", %{conn: conn, apartment: apartment} do
      b = Map.merge(@create_attrs, %{apartment_id: apartment.id})
      conn = post(conn, ~p"/api/bookings", booking: b)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/bookings/#{id}")

      assert %{
               "id" => ^id,
               "check_in" => valid_check_in_date,
               "check_out" => valid_check_out_date,
               "deposit" => 100_000,
               "monthly_rent" => 250_000,
               "utilities" => 20000
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, apartment: apartment} do
      b = Map.merge(@invalid_attrs, %{apartment_id: apartment.id})
      conn = post(conn, ~p"/api/bookings", booking: b)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_booking(_) do
    booking = booking_fixture()
    %{booking: booking}
  end
end
