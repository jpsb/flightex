defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.CreateOrUpdate, as: CreateOrUpdateBooking
  alias Flightex.Bookings.Read, as: ReadBooking
  alias Flightex.Bookings.Report, as: ReportBookings

  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate, as: CreateOrUpdateUser

  def start_agents do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  defdelegate create_user(params), to: CreateOrUpdateUser, as: :call
  defdelegate create_booking(user_id, params), to: CreateOrUpdateBooking, as: :call
  defdelegate get_booking(booking_id), to: ReadBooking, as: :call
  defdelegate generate_report(from_date, to_date), to: ReportBookings, as: :call
end
