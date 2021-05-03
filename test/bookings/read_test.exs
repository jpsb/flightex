defmodule Flightex.Bookings.ReadTest do
  use ExUnit.Case
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.CreateOrUpdate
  alias Flightex.Bookings.Read
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Bookings.Booking

  import Flightex.Factory

  describe "call/1" do
    setup %{} do
      BookingAgent.start_link(%{})
      UserAgent.start_link(%{})
      :ok
    end

    test "when the booking is found, returns the booking" do
      {:ok, user_id} = UserAgent.save(build(:user))

      booking_params = %{
        data_completa: "2021-05-01 15:07:00",
        cidade_origem: "Fortaleza",
        cidade_destino: "Brasilia"
      }

      {:ok, booking_id} = CreateOrUpdate.call(user_id, booking_params)

      {:ok, booking} = Read.call(booking_id)

      expected_response = %Booking{
        cidade_destino: "Brasilia",
        cidade_origem: "Fortaleza",
        data_completa: ~N[2021-05-01 15:07:00],
        id: booking_id,
        id_usuario: user_id
      }

      assert expected_response == booking
    end

    test "when the booking is not found, returns an error" do
      response = Read.call("6666-6666")
      expected_response = {:error, "Flight Booking not found"}
      assert expected_response == response
    end
  end
end
