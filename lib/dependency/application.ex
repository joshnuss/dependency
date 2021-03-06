defmodule Dependency.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: Dependency.Registry}
    ]

    opts = [strategy: :one_for_one, name: Dependency.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
