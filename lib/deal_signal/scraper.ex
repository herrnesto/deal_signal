defmodule DealSignal.Scraper do
  def scrape() do
    with html <- scrape_daydeal() do
      %{}
      |> Map.put(:provider, "daydeal")
      |> extract(html, {:name, "h2.product-description__title2"})
      |> extract(html, {:content, ".tab-content, .tab-pane:first-child"})
      |> extract_url(html)
      |> extract_image(html, {:image_url, ".product-img-main-pic"})
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

  def extract_url(args, parsed_html) do
    url =
      Floki.attribute(parsed_html, "*[property='og:url']", "content")
      |> List.first()

    args
    |> Map.put_new(:deal_url, url)
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

  def extract_image(args, parsed_html, {field, filter}) do
    with text <- extract_image(parsed_html, filter) do
      args
      |> Map.put_new(field, text)
    end
  end

  def extract_image(parsed_html, filter) do
    parsed_html
    |> Floki.find(filter)
    |> Floki.attribute("src")
    |> List.first()
  end

  def strip_deal_id(args, parsed_html) do
    value =
      parsed_html
      |> Floki.find(".product, .js-product")
      |> Floki.raw_html()
      |> regex(~r/(?<=data-id=")[^"]+(?=")/)
      |> List.first()

    Map.put(args, :deal_id, value)
  end

  def regex(html, pattern) do
    Regex.run(pattern, html)
  end

  def strip_deal_end(args, parsed_html) do
    value =
      parsed_html
      |> Floki.find(".product-bar__offer-ends, span")
      |> Floki.raw_html()
      |> regex(~r/(?<=data-next-deal=")[^"]+(?=")/)
      |> List.first()

    Map.put(args, :deal_end, value)
  end
end
