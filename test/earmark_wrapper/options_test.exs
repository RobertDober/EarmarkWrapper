defmodule EarmarkWrapper.OptionsTest do
  use ExUnit.Case

  alias Earmark.Options, as: EO
  alias EarmarkWrapper.Options

  describe "empty" do
    test "empty input -> default values" do
      assert Options.parse([]) == %Options{}
    end
  end

  runner = fn( {options, args}) -> 
     args1 = if is_binary(args), do: [args], else: args

      test(Enum.join(args1," ")) do
        expected = struct(Options, unquote(Macro.escape options))
        actual   = Options.parse(unquote(Macro.escape args1))

        assert actual == expected
      end
    end

  describe "parameters" do
    [
      { %{help: true, earmark_options: %EO{}}, "--help"},
      { %{help: true}, "-h"},
      { %{version: true}, "--version"},
      { %{version: true}, "-v"},
      { %{input: ~w{xxx yyy}, javascript: "jsfile", lang: "fr", title: "Mr."},
        ~w{--lang fr -t=Mr. --javascript jsfile xxx yyy}},

      { %{errors: [{"--xxx", nil}]}, ~w{--xxx}}
    ] |> Enum.each(runner)
  end

  describe "Earmark parameters" do 
    [
      {%{earmark_options: %EO{footnotes: true, footnote_offset: 0}}, ~w{--earmark-options footnotes,footnote_offset=0}},
      {%{earmark_options: %EO{footnotes: true, footnote_offset: 0}}, ~w{-e footnotes=true,footnote_offset=0}},
      {%{earmark_options: %EO{timeout: 200, gfm: false}}, ~w{--earmark-options timeout=200,gfm=false}},

      {%{earmark_options: %EO{}, errors: ["illegal is not a legal Earmark option"]}, ~w{-e illegal}},
    ] |> Enum.each(runner)
  end


  describe "mixed" do
    [
      { %{earmark_options: %EO{pedantic: true}, input: ~w{alpha}, stylesheet: "stylesheet", title: "Ms."},
        ~w{-e pedantic -s stylesheet --title Ms. alpha}}
    ] |> Enum.each(runner)
  end
end
