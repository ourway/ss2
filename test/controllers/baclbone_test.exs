defmodule Ss2.BackboneTest do
  use Ss2.ConnCase
  use Database

  setup do
    :ok

    on_exit fn ->
      :ok
    end
  end



  test "test GET /api/ping", %{conn: conn} do
    conn = get conn, "/api/ping"
    assert json_response(conn, 200) == %{"message" => "pong"}
  end


  test "test Store and restore a user's data to mnesia" do
    :ok
  end

  test "test link Database create function" do
    :ok
  end





end
