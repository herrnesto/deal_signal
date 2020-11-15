defmodule Engine.Scraper do

  def scrape() do
    with html <- Engine.Scraper.scrape() do
      %{}
      |> extract(html, {:article, "h2.product-description__title2"})
      |> extract(html, {:content, ".tab-content, .tab-pane:first-child"})
      |> extract(html, {:image, ".product-img-main-pic"})
      |> strip_deal_id(html)
      |> strip_deal_end(html)
    end
  end

  def scrape_daydeal() do
    HTTPoison.get!("https://www.daydeal.ch")
    |> Map.get(:body)
    |> String.replace(~r/>[ \n\r]+</, ">&#32;<")
    |> Floki.parse_document!()
  end

  def extract(args, parsed_html, {field, filter}) do
    with text <- extract(parsed_html, filter) do
      args
      |> Map.put_new(field, text)
    end
  end

  def extract(parsed_html, filter) do
    parsed_html
    |> Floki.find(filter)
    |> Floki.text()
  end

  def strip_deal_id(args, html) do
    with {:ok, parsed_html} <- Floki.parse_document(html) do
      value =
        parsed_html
        |> Floki.find(".product, .js-product")
        |> Floki.raw_html()
        |> regex(~r/(?<=data-id=")[^"]+(?=")/)
        |> List.first()

      Map.put(args, :deal_id, value)
    end
  end

  def regex(html, pattern) do
    Regex.run(pattern, html)
  end

  def strip_deal_end(args, html) do
    with {:ok, parsed_html} <- Floki.parse_document(html) do
      value =
        parsed_html
        |> Floki.find(".product-bar__offer-ends, span")
        |> Floki.raw_html()
        |> regex(~r/(?<=data-next-deal=")[^"]+(?=")/)
        |> List.first()

      Map.put(args, :deal_end, value)
    end
  end
end
