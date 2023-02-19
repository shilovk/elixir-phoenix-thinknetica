defmodule M do
  use GenServer

  def init(init_arg) do
    {:ok, init_arg}
  end

  def start_link, do: GenServer.start_link(M, :ok, name: M)

  def node_name, do: IO.puts(Node.self)

  def pwd, do: IO.puts(File.cwd!)

  def waiting_ok, do: receive(do: (:ok -> IO.puts("OK")))
end

M.node_name
M.pwd
