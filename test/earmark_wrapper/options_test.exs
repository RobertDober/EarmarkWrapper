defmodule EarmarkWrapper.OptionsTest do
  use ExUnit.Case

  alias EarmarkWrapper.Options

  describe "empty" do
    test "empty input -> default values" do
      expected = %Options{}
      {:ok, actual} = Options.parse([])

      assert actual == expected
    end
  end

  describe  "single param" do
    test "help" do
      expected = %Options{help: true}
      {:ok, actual} = Options.parse(["--help"])

      assert actual == expected
    end
  end

end
