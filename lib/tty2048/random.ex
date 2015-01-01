defmodule Tty2048.Random do
  use GenServer

  def start_link, do: start_link(:os.timestamp)

  def start_link(seed) do
    GenServer.start_link(__MODULE__, seed, [name: __MODULE__])
  end

  def init(seed) do
    :random.seed(seed)
    {:ok, nil}
  end

  def random do
    GenServer.call(__MODULE__, {:random, nil})
  end

  def random(num) do
    GenServer.call(__MODULE__, {:random, num})
  end

  def handle_call({:random, num}, _from, nil) do
    {:reply, uniform(num), nil}
  end

  defp uniform(nil), do: :random.uniform
  defp uniform(num), do: :random.uniform(num)
end
