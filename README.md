# Inject

Dependency injection to simplify your unit testing.

Inspired by [constantizer](https://github.com/aaronrenner/constantizer)

## Installation

The package can be installed by adding `inject` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:inject, "~> 0.1.0"}
  ]
end
```

## Usage

Dependency injection allows you to swap out dependencies when you test your objects.

In test mode a `Registry` is used that holds a mapping between dependency name and implementation.

### Resolving a dependency

```elixir
import Inject

mod = Inject.resolve(MyModule)
```

### Registering an implementation

```elixir
Inject.register(MyModule, MyImplementation)
```

## License

MIT
