defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def call(from_date, to_date) do
    with {:ok, formated_from_date} <- NaiveDateTime.from_iso8601(from_date),
         {:ok, formated_to_date} <- NaiveDateTime.from_iso8601(to_date) do
      BookingAgent.list_all()
      |> Map.values()
      |> Enum.filter(fn booking ->
        filter_by_date(booking, formated_from_date, formated_to_date)
      end)
      |> generate_report()
    else
      {:error, :invalid_format} ->
        {:error, "Invalid date format. Example of valid format: YYYY-MM-DD hh:mm:ss"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp filter_by_date(%Booking{data_completa: data}, from_date, to_date) do
    case greater_than?(NaiveDateTime.compare(data, from_date)) do
      true ->
        case greater_than?(NaiveDateTime.compare(to_date, data)) do
          true ->
            true

          _ ->
            false
        end

      _ ->
        false
    end
  end

  defp greater_than?(compared_value) when compared_value in [:gt, :eq], do: true
  defp greater_than?(_compared_value), do: false

  defp generate_report(bookings) do
    bookings_list = build_bookings_list(bookings)
    filename = "bookings_report.csv"
    File.write(filename, bookings_list)
    {:ok, "Report generated successfully"}
  end

  defp build_bookings_list(bookings) do
    bookings
    |> Enum.map(fn booking -> booking_string(booking) end)
  end

  defp booking_string(%Booking{
         data_completa: data,
         cidade_origem: origem,
         cidade_destino: destino,
         id_usuario: id_usuario
       }) do
    "#{id_usuario},#{origem},#{destino},#{data}\n"
  end
end
