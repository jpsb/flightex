# Flightex

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `flightex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:flightex, "~> 0.1.0"}
  ]
end
```

## Testing application
```elixir
Flightex.start_agents()

user_params = %{name: "Joao Paulo Barros", email: "jpsb@email.com", cpf: "12345678912"}

{:ok, user_id} = Flightex.create_user(user_params)

booking_params = %{data_completa: "2021-05-01 15:07:00", cidade_origem: "Fortaleza", cidade_destino: "Brasilia"}

{:ok, booking_id} = Flightex.create_booking(user_id, booking_params)

Flightex.get_booking(booking_id)

Flightex.generate_report("2021-04-10 10:10:00", "2021-05-02 10:10:00")


```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/flightex](https://hexdocs.pm/flightex).
