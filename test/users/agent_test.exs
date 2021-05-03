defmodule Flightex.Users.AgentTest do
  use ExUnit.Case
  alias Flightex.Users.Agent, as: UserAgent
  import Flightex.Factory

  setup do
    UserAgent.start_link(%{})
    user = build(:user)
    {:ok, user: user}
  end

  describe "save/1" do
    test "saves the user", %{user: user_params} do
      response = UserAgent.save(user_params)
      expected_response = {:ok, user_params.id}
      assert expected_response == response
    end
  end

  describe "get/1" do
    test "when the user is found, returns the user", %{user: user_params} do
      UserAgent.save(user_params)
      response = UserAgent.get(user_params.id)

      expected_response = {:ok, user_params}

      assert expected_response == response
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("6666-6666")
      expected_response = {:error, "User not found"}
      assert expected_response == response
    end
  end
end
