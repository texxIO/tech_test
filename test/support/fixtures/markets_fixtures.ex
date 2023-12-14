defmodule Ukio.MarketsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ukio.Markets` context.
  """

  @doc """
  Generate a market.
  """
  def market_fixture(attrs \\ %{}) do
    {:ok, market} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Ukio.Markets.create_market()

    market
  end
end
