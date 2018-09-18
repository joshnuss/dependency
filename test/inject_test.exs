defmodule InjectTest do
  use ExUnit.Case
  doctest Inject

  test "greets the world" do
    assert Inject.hello() == :world
  end
end
