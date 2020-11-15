defmodule DealSignal.ScraperTest do
  use ExUnit.Case
  doctest Engine

  alias Engine.Scraper

  test "extract\2" do
    parsed_html = Floki.parse_document!("<html><h1 class=\"test\">Titel<h1></html>")

    assert Scraper.extract(parsed_html, ".test") == "Titel"
  end

  test "extract\4" do
    parsed_html = Floki.parse_document!("<html><h1 class=\"test\">Titel<h1></html>")
    args = %{}
    result = Scraper.extract(args, parsed_html, {:test, ".test"})
    assert result == %{test: "Titel"}
  end

  test "strip_deal_id\2" do
    html =
      '<section class="product js-product" data-id="72102" data-deal-id="6955" data-type="daily">'

    assert Scraper.strip_deal_id(%{}, html) == %{deal_id: "72102"}
  end

  test "strip_deal_end\2" do
    html = 'div class="col"><div class="product-bar__offer-ends">Nächstes Angebot in
    <span data-next-deal="2020-04-25 07:00:00" class="js-clock">&nbsp;</span></div></div>'

    assert Scraper.strip_deal_end(%{}, html) == %{deal_end: "2020-04-25 07:00:00"}
  end
end
