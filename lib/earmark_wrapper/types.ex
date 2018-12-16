defmodule EarmarkWrapper.Types do
  
  defmacro __using__( _options) do
    quote do

      # TODO: As soon as Earmark types `Earmark.as_html` use its return type instead
      @type earmark_return_t :: { status(), String.t, Earmark.Message.ts }
      @type either(t) :: {:ok, t} | {:error, String.t}

      @type keywd_map() :: %{atom() => any()}
      @type maybe(t) :: t | nil

      @type pair(t)  :: {t, t}
      @type pair(t, u)  :: {t, u}

      @type parsed_options_t :: { OptionParser.parsed(), OptionParser.argv(), OptionParser.errors() }

      @type status :: :ok | :error

    end
  end
end
