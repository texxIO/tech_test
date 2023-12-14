# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ukio.Repo.insert!(%Ukio.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Ukio.Repo.insert!(%Ukio.Markets.Market{
  name: "Earth"
})

Ukio.Repo.insert!(%Ukio.Markets.Market{
  name: "Mars"
})

Ukio.Repo.insert!(%Ukio.Apartments.Apartment{
  zip_code: "08007",
  name: "CAPITAN",
  monthly_price: 250_000,
  address: "Carrer de Balmes 76",
  square_meters: 120,
  market_id: 1,
  utility_rate: 0.0
})

Ukio.Repo.insert!(%Ukio.Apartments.Apartment{
  zip_code: "08007",
  name: "CAPITAN",
  monthly_price: 195_000,
  address: "Carrer de Granados 45",
  square_meters: 89,
  market_id: 2,
  utility_rate: 0.5
})
