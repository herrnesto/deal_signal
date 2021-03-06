defmodule DealSignal.Deals do
  alias DealSignal.Deals.Deal
  alias DealSignal.Repo

  @doc """
  data = %{
  provider: "daydeal",
  manufacturer: "Philips",
  name: "Hue bulb E10",
  image_url: "https://picsum.photos/800/600",
  deal_end: ~N[2020-11-15 03:30:55.409023Z],
  deal_id: 1234,
  deal_url: "www.url.com"
  }
  """
  def create(params) do
    case exists?(params) do
      nil ->
        %Deal{}
        |> Deal.changeset(params)
        |> Repo.insert()

      _ ->
        %Deal{}
        |> Deal.error()
    end
  end

  def exists?(%{provider: provider, deal_id: deal_id}) do
    Deal
    |> Repo.get_by(%{provider: provider, deal_id: deal_id})
  end
end
