defmodule Engine.Profile do
  @moduledoc """
  Documentation for search profiles.
  """

  def terms() do
    ["hue", "lampe"]
  end

  def validate([], _string), do: false

  def validate([head | tail], string) do
    case String.downcase(string) =~ String.downcase(head) do
      true -> true
      false -> validate(tail, string)
    end
  end
end
