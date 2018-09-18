# Dependency

Dependency injection to simplify your unit testing.

Inspired by [constantizer](https://github.com/aaronrenner/constantizer)

## Installation

The package can be installed by adding `dependency` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:dependency, "~> 0.1.0"}
  ]
end
```

Also, you'll need to add the application to your list of applications

```elixir
def application do
  [
    # ...
    extra_applications: [:dependency],
  ]
end
```

## Usage

Dependency injection allows you to swap out dependencies when you test your objects.

In test mode a `Registry` is used that holds a mapping between dependency name and implementation.

### Resolving a dependency

```elixir
import Dependency

mod = Dependency.resolve(MyModule)
```

### Registering an implementation

```elixir
Dependency.register(MyModule, MyImplementation)
```

## License

MIT
