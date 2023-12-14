defmodule Ukio.Markets.MarketConditions do
  def get_conditions(apartment) do

    case apartment.market_id do
      2 ->
        %{
          utilities: calculate_utility_cost(apartment.square_meters, apartment.utility_rate),
          deposit: apartment.monthly_price
        }
      _ ->
        base_costs()
    end
  end

  def calculate_utility_cost(square_meters, utility_rate) do
    utility_rate * square_meters
  end

  def base_costs do
    %{
      utilities: 20_000,
      deposit: 100_000,
    }
  end
end
