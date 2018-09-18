defmodule Inject do
  alias Inject.MissingError

  def start_link do
    Registry.start_link(keys: :unique, name: Dependency.Registry)
  end

  def register(name, implementation) do
    case Registry.register(Dependency.Registry, name, implementation) do
      {:ok, pid} ->
        {:ok, pid}
      {:error, {:already_registered, _pid}} ->
        :ok = Registry.unregister(Dependency.Registry, name)
        register(name, implementation)
    end
  end

  defmacro resolve(name) do
    quote do
      if Mix.env() == :test do
        dynamically_resolve(unquote(name))
      else
        unquote(name)
      end
    end
  end

  def dynamically_resolve(name) do
    case Registry.lookup(Dependency.Registry, name) do
      [{_pid, implementation}] ->
        implementation
      [] ->
        raise MissingError, message: "dependency #{name} is not registered"
    end
  end
end
