defmodule Flightex.Users.UserTest do
  use ExUnit.Case
  alias Flightex.Users.User
  import Flightex.Factory

  describe "build/3" do
    test "when all params are valid, returns the user" do
      {:ok, %User{id: id_usuario} = response} =
        User.build("Joao Paulo Barros", "jpsb@jpsb.com", "12345678912")

      expected_response = build(:user, id: id_usuario)

      assert expected_response == response
    end

    test "when there are invalid params, returns an error" do
      response = User.build("Joao Paulo Barros", "jpsb@jpsb.com", 12_345_678_912)
      expected_response = {:error, "Invalid parameters"}
      assert expected_response == response
    end
  end
end
