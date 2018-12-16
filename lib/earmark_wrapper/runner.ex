defmodule EarmarkWrapper.Runner do
  use EarmarkWrapper.Types

  alias EarmarkWrapper.Options

  @earmark_interface Application.fetch_env!(:earmark_wrapper, :earmark_interface)

  @type result_t :: { status(), list(String.t), Earmark.Message.ts } 

  @moduledoc """
  Compiles the output depending on `EarmarkWrapper.Options` and the transformed markdown
  """
  

  @spec run(Options.t) :: status()
  def run(options) do
    { status, html, messages } = 
      Enum.reduce(options.input, {:ok, [""], []}, &convert_file(&1, &2, options))

    emit(messages)
    if status == :ok, do: render(html, options)
    status
  end


  @spec convert_file( String.t, result_t(), Options.t ) :: result_t()
  defp convert_file(input, {status, body, messages}=result, options) do
    case File.read(input) do
      {:ok, content}     -> convert_markdown(content, result, options)
      {:error, message } -> {:error, body, [ {:error, 0, "error reading file #{input}: #{message}"} | messages ]}
    end
  end

  @spec convert_markdown( String.t, result_t(), Options.t ) :: result_t()
  defp convert_markdown(markdown, {status, body, messages}, %{earmark_options: options}) do
    {status1, html, messages1} = @earmark_interface.as_html(markdown, options)
    {combine_stati(status, status1), [html | body], messages ++ messages1} 
  end


  @spec combine_stati(status(), status()) :: status()
  defp combine_stati(lhs, rhs)
  defp combine_stati(:ok, :ok), do: :ok
  defp combine_stati(_, _), do: :error


  @spec emit(Earmark.Message.ts) :: status()
  defp emit(messages)
  defp emit([]), do: :ok
  defp emit([{status, lnb, message} | rest]) do
    IO.puts(:stderr, "#{status} #{lnb}: #{message}")
    emit(rest)
  end

  @spec render( String.t, Options.t ) :: status()
  defp render(html, options) do
    IO.puts EarmarkWrapper.Renderer.render_html5(html, options)
  end
end
