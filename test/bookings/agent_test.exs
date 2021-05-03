defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case
  alias Flightex.Bookings.Agent, as: BookingAgent
  import Flightex.Factory

  setup do
    BookingAgent.start_link(%{})
    booking = build(:booking)
    {:ok, booking: booking}
  end

  describe "save/1" do
    test "saves the booking", %{booking: booking} do
      response = BookingAgent.save(booking)
      assert {:ok, _booking_id} = response
    end
  end

  describe "get/1" do
    test "when the booking is found, returns the booking", %{booking: booking} do
      BookingAgent.save(booking)
      response = BookingAgent.get(booking.id)
      expected_response = {:ok, booking}
      assert expected_response == response
    end

    test "when the booking is not found, returns an error" do
      response = BookingAgent.get("6666-6666")
      expected_response = {:error, "Flight Booking not found"}
      assert expected_response == response
    end
  end

  describe "list_all/0" do
    test "list all bookings" do
      booking1 = build(:booking, id: "4444-4444")
      booking2 = build(:booking, id: "3333-3333")

      BookingAgent.save(booking1)
      BookingAgent.save(booking2)

      response =
        BookingAgent.list_all()
        |> Enum.count()

      expected_response = 2

      assert expected_response == response
    end
  end
end
