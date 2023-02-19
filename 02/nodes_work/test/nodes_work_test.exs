defmodule NodesWorkTest do
  use ExUnit.Case
  doctest NodesWork

  test "greetings" do
    nodes = Cluster.start_nodes()
    assert {"Hello, Rob!", :"n2@127.0.0.1"} == NodesWork.create_greeting("Rob")
    assert {"Hello, Bob!", :"n3@127.0.0.1"} == NodesWork.create_greeting("Bob")
    Cluster.stop_nodes(nodes)
  end
end
