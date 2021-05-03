defmodule Flightex.Users.CreateOrUpdateTest do
  use ExUnit.Case
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate

  describe "call/1" do
    setup %{} do
      UserAgent.start_link(%{})
      :ok
    end

    test "when all params are valid, saves the booking" do
      params = %{name: "Jpsb", email: "jpsb@email.com", cpf: "12345678912"}
      assert {:ok, _user_id} = CreateOrUpdate.call(params)
    end

    test "when there are invalid params, returns an error" do
      params = %{name: "Jpsb", email: "jpsb@email.com", cpf: 12_345_678_912}
      response = CreateOrUpdate.call(params)
      expected_response = {:error, "Invalid parameters"}
      assert expected_response == response
    end
  end
end
