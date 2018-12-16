defmodule EarmarkWrapper.EarmarkInterface.Implementation do
  use EarmarkWrapper.Types

  @behaviour EarmarkWrapper.EarmarkInterface.Behaviour

  @impl true
  @spec as_html( String.t, Earmark.Options.t ) :: earmark_return_t()
  def as_html(string, options), do: Earmark.as_html(string, options)
end
