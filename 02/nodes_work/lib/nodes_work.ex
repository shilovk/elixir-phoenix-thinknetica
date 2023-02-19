defmodule NodesWork do
  @moduledoc """
  Documentation for `NodesWork`.
  """

  alias NodesWork.Router

  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl GenServer
  def init(state), do: {:ok, state}


  @impl GenServer
  #  @spec calc_fib(non_neg_integer()) :: {non_neg_integer(), atom()}
  def create_greeting(name \\ "Bob") do
    GenServer.call(__MODULE__, {:create_greeting, name})
  end

  @impl GenServer
  def handle_call({:create_greeting, name}, _from, state) do
    next = GenServer.call(Router, :take_node)

    next_node =
      case node() do
        ^next -> GenServer.call(Router, :take_node)
        _ -> next
      end

    Node.spawn(next_node, __MODULE__, :send_greeting, [name, self()])

    receive do
      {:reply, greeting, node_name} ->
        IO.puts("Greeting from node: #{node_name}")
        {:reply, {greeting, node_name}, state}
    end
  end

  def send_greeting(name, pid) do
    send(pid, {:reply, "Hello, #{name}!", node()})
  end

  def send_greeting(name) do
    "Hello, #{name}!"
  end
end
