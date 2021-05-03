defmodule Flightex.Bookings.Agent do
  alias Flightex.Bookings.Booking

  use Agent

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{} = booking) do
    Agent.update(__MODULE__, &update_state(&1, booking))
    {:ok, booking.id}
  end

  def get(uuid), do: Agent.get(__MODULE__, &get_booking(&1, uuid))

  defp get_booking(state, uuid) do
    case Map.get(state, uuid) do
      nil -> {:error, "Flight Booking not found"}
      booking -> {:ok, booking}
    end
  end

  def list_all, do: Agent.get(__MODULE__, & &1)

  defp update_state(state, %Booking{id: uuid} = booking), do: Map.put(state, uuid, booking)
end
