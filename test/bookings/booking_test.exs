defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case
  alias Flightex.Bookings.Booking
  alias Flightex.Users.User
  import Flightex.Factory

  describe "build/3" do
    test "when all params are valid, returns the booking" do
      {:ok, %User{id: id_usuario} = user} =
        User.build("Joao Paulo Barros", "jpsb@jpsb.com", "12345678912")

      data = ~N[2021-04-30 11:55:00]

      {:ok, %Booking{id: id_booking} = response} =
        Booking.build(user, data, "Teresina", "Fortaleza")

      expected_response =
        build(:booking, data_completa: data, id: id_booking, id_usuario: id_usuario)

      assert expected_response == response
    end

    test "when there is invalid user param, returns an error" do
      user = User.build("Joao Paulo Barros", "jpsb@jpsb.com", 12_345_678_912)

      data = ~N[2021-04-30 11:55:00]

      response = Booking.build(user, data, "Teresina", "Fortaleza")

      expected_response = {:error, "Invalid parameters"}

      assert expected_response == response
    end

    test "when there are invalid params, returns an error" do
      {:ok, user} = User.build("Joao Paulo Barros", "jpsb@jpsb.com", "12345678912")

      data = ~N[2021-04-30 11:55:00]

      response = Booking.build(user, data, "Teresina", Fortaleza)

      expected_response = {:error, "Invalid parameters"}

      assert expected_response == response
    end
  end
end
