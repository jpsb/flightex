defmodule Flightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.CreateOrUpdate
  alias Flightex.Users.Agent, as: UserAgent
  import Flightex.Factory

  describe "call/1" do
    setup %{} do
      BookingAgent.start_link(%{})
      UserAgent.start_link(%{})
      :ok
    end

    test "when all params are valid, saves the user" do
      {:ok, user_id} = UserAgent.save(build(:user))

      booking_params = %{
        data_completa: "2021-05-01 15:07:00",
        cidade_origem: "Fortaleza",
        cidade_destino: "Brasilia"
      }

      assert {:ok, _booking_id} = CreateOrUpdate.call(user_id, booking_params)
    end

    test "when there are invalid params, returns an error" do
      {:ok, user_id} = UserAgent.save(build(:user))

      booking_params = %{
        data_completa: "2021-05-01 15:07:00",
        cidade_origem: "Fortaleza",
        cidade_destino: Brasilia
      }

      response = CreateOrUpdate.call(user_id, booking_params)

      expected_response = {:error, "Invalid parameters"}
      assert expected_response == response
    end
  end
end
