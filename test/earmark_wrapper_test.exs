defmodule EarmarkWrapperTest do
  use ExUnit.Case

  alias Support.EarmarkWrapper.EarmarkInterface.Mock

  # doctest EarmarkWrapper

  setup do
    Mock.start_link
    :ok
  end

  describe "default behavior (no options)" do
    test "we include Earmark's output into the result" do
      {:ok, result, []} = Mock.as_html(1)
      assert Mock.messages == [{1, %Earmark.Options{}, result}]
    end
    test "we include Earmark's output into the result... ...again" do
      {:ok, result, []} = Mock.as_html(2)
      assert Mock.messages == [{2, %Earmark.Options{}, result}]
    end
  end
end
