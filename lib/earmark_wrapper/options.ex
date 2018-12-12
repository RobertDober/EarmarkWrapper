defmodule EarmarkWrapper.Options do
  use EarmarkWrapper.Types

  defstruct \
    earmark_options: %{},
    help: false,
    html5: true,
    input: [],
    javascript: nil,
    lang: "en",
    stylesheet: nil,
    title: nil,
    version: false

  @type t :: %__MODULE__{
    earmark_options: keywd_map(),
    help: boolean(),
    html5: boolean(),
    input: list(String.t),
    javascript: maybe(String.t),
    lang: String.t,
    stylesheet: maybe(String.t),
    title: maybe(String.t),
    version: boolean()
  }
  @type positional_args_t :: OptionParser.argv()
  @type parsed_t :: {t(), positional_args_t()}
  @type result_t :: either(t())


  @spec parse(list(String.t)) :: result_t()
  def parse args do
    OptionParser.parse(args, strict: switches(), aliases: aliases())
    |> transform()
  end
  # For OptionParser
  #--------------------------------

  @spec aliases() :: Keyword.t()
  defp aliases, do: [e: :earmark_options, h: :help, j: :javascript, l: :lang, s: :stylesheet, t: :title, v: :version]

  @spec switches() :: Keyword.t()
  defp switches do
    # Lots of duplication here
    [
      earmark_options: :string, # Needs parsing
      help: :boolean,
      html5: :boolean,
      javascript: :string,
      lang: :string,
      stylesheet: :string,
      title: :string,
      version: :boolean
    ]
  end

  @spec transform( parsed_options_t() ) :: result_t()
  defp transform parsed_options
  defp transform( {options, positional, []}=x ) do
    myself = from_options(options, %__MODULE__{input: positional})
    {:ok, myself}
  end
  defp transform( {_, _, errors} ) do
    {:error, "Illegal options #{inspect errors}"}
  end

  @spec from_options(OptionParser.parsed, t())::t()
  defp from_options(options, result)
  defp from_options([], result), do: result
  defp from_options([{key, value}|rest], result), do: from_options(rest, %{result | key => value})



end
