defmodule EarmarkWrapper.Options do
  use EarmarkWrapper.Types

  alias EarmarkWrapper.EarmarkOptions

  defstruct \
  earmark_options: %Earmark.Options{},
  errors: [],
  help: false,
  html5: true,
  input: [],
  javascript: nil,
  lang: "en",
  stylesheet: nil,
  title: nil,
  version: false

  @type t :: %__MODULE__{
    earmark_options: Earmark.Options.t,
    errors: list(String.t),
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


  @spec parse(list(String.t)) :: t()
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
      earmark_options: :string,
      help: :boolean,
      html5: :boolean,
      javascript: :string,
      lang: :string,
      stylesheet: :string,
      title: :string,
      version: :boolean
    ]
  end


  # Postprocessing
  # --------------------------------

  @spec transform( parsed_options_t()) :: t()
  defp transform( parsed_options )
  defp transform( {options, positional, []} ) do
    _transform(options, %__MODULE__{input: positional})
  end
  defp transform( {_, _, errors} ) do
    %__MODULE__{errors: errors}
  end

  @spec _transform(OptionParser.parsed, t()) :: t()
  defp _transform(options, result) do
    options
    |> Enum.reduce(result, &_update/2)
  end

  @spec _update({atom(), String.t}, t()) :: t()
  defp _update(keyvalpair, result)
  defp _update({:earmark_options, earmark_options}, result) do
    case EarmarkOptions.parse(earmark_options) do
      {:ok, earmark_options1} -> %{result | earmark_options: earmark_options1}
      {:error, message}       -> %{result | earmark_options: %Earmark.Options{}, errors: [message | result.errors]}
    end
  end
  defp _update({k, v}, result) do
    %{result | k => v}
  end


end
