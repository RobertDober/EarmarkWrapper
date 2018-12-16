defmodule Support.EarmarkWrapper.EarmarkInterface.Mock do

  use EarmarkWrapper.Types
  import Support.Random, only: [random_string: 0]

  @behaviour EarmarkWrapper.EarmarkInterface.Behaviour


  def start_link do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end


  def clear do
    Agent.update(__MODULE__, fn _ -> [] end)
  end

  def messages do
     Agent.get(__MODULE__, &(&1))
  end

  @impl true
  @spec as_html( String.t, Earmark.Options.t ) :: earmark_return_t()
  def as_html(string, options \\ %Earmark.Options{}) do
    result = random_string()
    Agent.update(__MODULE__, fn messages -> [ {string, options, result} | messages ] end)
    {:ok, result, []}
  end
end
