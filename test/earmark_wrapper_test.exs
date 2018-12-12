defmodule EarmarkWrapperTest do
  use ExUnit.Case
  doctest EarmarkWrapper

  test "greets the world" do
    assert EarmarkWrapper.hello() == :world
  end
end
