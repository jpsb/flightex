defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.CreateOrUpdate
  alias Flightex.Bookings.Report
  alias Flightex.Users.Agent, as: UserAgent

  import Flightex.Factory

  describe "call/1" do
    setup %{} do
      BookingAgent.start_link(%{})
      UserAgent.start_link(%{})
      :ok
    end

    test "when all params are valid, generates the report of bookings" do
      {:ok, user_id} = UserAgent.save(build(:user))

      booking_params = %{
        data_completa: "2021-05-01 15:07:00",
        cidade_origem: "Fortaleza",
        cidade_destino: "Brasilia"
      }

      CreateOrUpdate.call(user_id, booking_params)

      response = Report.call("2021-04-30 10:00:00", "2021-05-01 22:00:00")

      expected_response = {:ok, "Report generated successfully"}

      assert expected_response == response
    end

    test "when there is invalid params, returns an error" do
      response = Report.call("2021-02-31 10:00:00", "2021-02-31 22:00:00")
      expected_response = {:error, :invalid_date}
      assert expected_response == response
    end
  end
end
