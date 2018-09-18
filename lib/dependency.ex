defmodule Dependency do
  @moduledoc """
  Fuctions to build soft dependencies between modules. This is useful when you want to test with diffirent situations in test mode.

  The resolution is dynamic in test mode (uses `Registry`). In dev and production modes, the dependency in compiled inline.
  """
  alias Dependency.MissingError

  @doc """
  Start the dependency registry. This is done for you if you add `:dependency` to list of apps in your `mix.exs`.

  Returns `{:ok, pid}`
  """
  @spec start_link :: {:ok, pid()} | {:error, atom()}
  def start_link do
    Registry.start_link(keys: :unique, name: Dependency.Registry)
  end

  @doc """
  Register an implementation for a module.

  Returns `{:ok, module}`


  ## Examples

    iex> Dependency.register(Foo, Bar)
    {:ok, Bar}

  """
  @spec register(module(), module()) :: {:ok, module()}
  def register(mod, implementation) do
    case Registry.register(Dependency.Registry, mod, implementation) do
      {:ok, _pid} -> {:ok, implementation}
      {:error, {:already_registered, _pid}} ->
        :ok = Registry.unregister(Dependency.Registry, mod)
        register(mod, implementation)
    end
  end

  @doc """
  Resolve the implementation for a module.

  Returns `module`


  ## Examples

    iex> Dependency.register(Foo, Bar)
    {:ok, Bar}
    iex> Dependency.resolve(Foo)
    Bar

  """
  @spec resolve(module()) :: module()
  defmacro resolve(name) do
    quote do
      if Mix.env() == :test do
        Dependency.dynamically_resolve(unquote(name))
      else
        unquote(name)
      end
    end
  end

  @doc false
  def dynamically_resolve(name) do
    case Registry.lookup(Dependency.Registry, name) do
      [{_pid, implementation}] ->
        implementation
      [] ->
        raise MissingError, message: "dependency #{name} is not registered"
    end
  end
end
