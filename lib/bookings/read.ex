defmodule Flightex.Bookings.Read do
  alias Flightex.Bookings.Agent, as: BookingAgent

  def call(booking_id) do
    booking_id
    |> BookingAgent.get()
  end
end
