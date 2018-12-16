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
      %{errors: []} = options -> Runner.run(options)
      _                       -> :error
    end
  end
end
