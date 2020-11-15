defmodule DealSignal.ProfileTest do
  use ExUnit.Case
  doctest Engine

  alias Engine.Profile

  test "terms" do
    assert Profile.terms() == ["hue", "lampe"]
  end

  test "validate/2" do
    assert Profile.validate(["hue"], "hue lampen") == true
    assert Profile.validate([], "hue lampen") == false
    assert Profile.validate(["hue Lampen"], "hue lampen") == true
    assert Profile.validate(["hue Lampen"], "romantic-hue lampen") == true
    assert Profile.validate(["lichter"], "hue lampen") == false
  end
end
