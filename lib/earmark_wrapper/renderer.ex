defmodule EarmarkWrapper.Renderer do
  require EEx

  alias EarmarkWrapper.Options

  @spec render_html5(String.t, Options.t) :: String.t
  EEx.function_from_file( :def, :render_html5, "templates/html5_template.html.eex", [:html, :options] )
end
