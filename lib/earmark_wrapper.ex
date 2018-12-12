defmodule EarmarkWrapper do
  use EarmarkWrapper.Types

  alias EarmarkWrapper.Options
  alias EarmarkWrapper.Runner

  @moduledoc """
  Wrapping the output of `Earmark.as_html` into a complete HTML document.
  """

  @spec main(list(String.t)) :: status()
  def main(args) do
    case Options.parse(args) do
      {:ok, options} -> Runner.run(options)
      _              -> :error
    end
  end
  @doc """
  Hello world.

  ## Examples

      iex> EarmarkWrapper.hello()
      :world

  """
  def hello do
    :world
  end
end
