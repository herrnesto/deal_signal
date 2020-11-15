defmodule DealSignal.Deals.Deal do
  use Ecto.Schema

  import Ecto.Changeset

  schema "deals" do
    field(:provider, :string)
    field(:manufacturer, :string)
    field(:name, :string)
    field(:image_url, :string)
    field(:deal_end, :naive_datetime)
    field(:deal_id, :integer)
    field(:deal_url, :string)

    timestamps()
  end

  @fields [:provider, :manufacturer, :name, :image_url, :deal_end, :deal_id, :deal_url]
  def changeset(deal, params \\ %{}) do
    deal
    |> cast(params, @fields)
    |> validate_required([:provider, :name, :image_url, :deal_end, :deal_id, :deal_url])
  end

  def error(deal) do
    deal
    |> change()
    |> add_error(:hourly, "record exists", additional: "This product is already existing")
  end
end
