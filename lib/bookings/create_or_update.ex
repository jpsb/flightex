defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Users.Agent, as: UserAgent

  def call(user_id, %{
        data_completa: data_completa,
        cidade_origem: cidade_origem,
        cidade_destino: cidade_destino
      }) do
    with {:ok, formated_date} <- NaiveDateTime.from_iso8601(data_completa),
         {:ok, user} <- UserAgent.get(user_id),
         {:ok, booking} <- Booking.build(user, formated_date, cidade_origem, cidade_destino) do
      save_booking(booking)
    else
      {:error, :invalid_format} ->
        {:error, "Invalid date format. Example of valid format: YYYY-MM-DD hh:mm:ss"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp save_booking(%Booking{} = booking) do
    BookingAgent.save(booking)
    {:ok, booking.id}
  end
end
