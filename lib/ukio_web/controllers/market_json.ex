defmodule UkioWeb.MarketJSON do
  alias Ukio.Markets.Market

  @doc """
  Renders a list of markets.
  """
  def index(%{markets: markets}) do
    %{data: for(market <- markets, do: data(market))}
  end

  @doc """
  Renders a single market.
  """
  def show(%{market: market}) do
    %{data: data(market)}
  end

  defp data(%Market{} = market) do
    %{
      id: market.id,
      name: market.name
    }
  end
end
