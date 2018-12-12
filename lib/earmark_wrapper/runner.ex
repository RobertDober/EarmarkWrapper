defmodule EarmarkWrapper.Runner do
  use EarmarkWrapper.Types

  alias EarmarkWrapper.Options

  @moduledoc """
  Compiles the output depending on `EarmarkWrapper.Options` and the transformed markdown
  """
  

  @spec run(Options.t) :: status()
  def run(options) do
    :ok
  end
end
