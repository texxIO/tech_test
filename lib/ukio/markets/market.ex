defmodule Ukio.Markets.Market do
  use Ecto.Schema
  import Ecto.Changeset

  schema "markets" do
    field :name, :string
    timestamps()
  end

  @doc false
  def changeset(market, attrs) do
    market
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
