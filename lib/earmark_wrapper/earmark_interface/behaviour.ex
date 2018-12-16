defmodule EarmarkWrapper.EarmarkInterface.Behaviour do
  use EarmarkWrapper.Types
  @callback as_html(String.t, Earmark.Options.t) :: earmark_return_t() 
end
