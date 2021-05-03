defmodule Flightex.Factory do
  # with Ecto
  use ExMachina

  alias Flightex.Users.User
  alias Flightex.Bookings.Booking

  def user_factory do
    %User{
      cpf: "12345678912",
      email: "jpsb@jpsb.com",
      name: "Joao Paulo Barros",
      id: "1234-5678"
    }
  end

  def booking_factory do
    %Booking{
      cidade_destino: "Fortaleza",
      cidade_origem: "Teresina",
      data_completa: ~N[2021-04-30 11:55:00],
      id: "8765-4321",
      id_usuario: "1234-5678"
    }
  end
end
