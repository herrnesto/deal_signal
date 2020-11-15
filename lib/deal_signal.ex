defmodule DealSignal do
  @moduledoc """
  DealSignal keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias DealSignal.{Deals, Scraper}

  def scrape_product() do
    Scraper.scrape()
    |> Deals.create()
  end
end
