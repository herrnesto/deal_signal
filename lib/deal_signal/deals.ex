defmodule Engine.Deals do
  alias DbAdapter.Deals.Deal
  alias DbAdapter.Repo

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
    %Deal{}
    |> Deal.changeset(params)
    |> Repo.insert()
  end
end