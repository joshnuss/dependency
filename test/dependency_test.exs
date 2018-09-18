defmodule DependencyTest do
  use ExUnit.Case
  doctest Dependency

  test "raises MissingError when dependency was not defined" do
    assert_raise Dependency.MissingError, fn ->
      Dependency.resolve(Foo)
    end
  end

  test "resolves with registered dependency" do
    Dependency.register(Foo, Bar)

    assert Bar == Dependency.resolve(Foo)
  end

  test "register replaces last value" do
    Dependency.register(Foo, Bar)
    Dependency.register(Foo, Baz)

    assert Baz == Dependency.resolve(Foo)
  end
end
