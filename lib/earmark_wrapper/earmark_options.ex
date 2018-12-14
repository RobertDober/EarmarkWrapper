defmodule EarmarkWrapper.EarmarkOptions do

  use EarmarkWrapper.Types

  alias Earmark.Options

  @moduledoc """
  Interface to `Earmark.Options`
  """

  @spec parse(String.t())::either(Options.t)
  def parse(earmark_options) do
    try do
      {:ok, _parse(earmark_options)}
    rescue
      ke in KeyError ->
        {:error, "#{ke.key} is not a legal Earmark option"}
    end
  end

  @spec _parse(String.t) :: Options.t
  defp _parse(earmark_options) do
    earmark_options
    |> String.split(",")
    |> Enum.reduce(%Options{}, &parse1earmark_option/2)
  end


  @spec parse1earmark_option( String.t, Options.t ) :: Options.t
  defp parse1earmark_option(option_text, result)
  defp parse1earmark_option(option_text, result) do
    tuple = option_text
            |> String.split("=", parts: 2)
            |> List.to_tuple
    case tuple do
      {lhs, "true"} -> check_and_transform({lhs, true}, result)
      {lhs, "false"} -> check_and_transform({lhs, false}, result)
      {lhs, rhs} -> check_and_transform({lhs, rhs}, result)
      {lhs}      -> check_and_transform({lhs, true}, result)
    end
  end

  @spec check_and_transform( pair(String.t, String.t|boolean()), Options.t ) :: Options.t
  defp check_and_transform(pair, result)
  # Ints
  defp check_and_transform({"footnote_offset", fo}, result) do
    {fo_val, _} = Integer.parse(fo)
    %{result | footnote_offset: fo_val}
  end
  defp check_and_transform({"timeout", to}, result) do
    {to_val, _} = Integer.parse(to)
    %{result | timeout: to_val}
  end
  # Strings
  defp check_and_transform({key, value}, result) do
    %{ result | String.to_atom(key) => value }
  end

end
