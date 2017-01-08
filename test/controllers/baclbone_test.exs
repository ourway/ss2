defmodule Ss2.BackboneTest do
  use Ss2.ConnCase
  #use Database

  setup do
    :ok

    on_exit fn ->
      url = "https://www.appido.ir/pages/gifts"
       Database.Link.remove(url)
      :ok
    end
  end

  test "test GET /api/ping", %{conn: conn} do
    conn = get conn, "/api/ping"
    assert json_response(conn, 200) == %{"message" => "pong"}
  end


  test "test saving a link and restoring it" do
    url = "https://www.appido.ir/pages/gifts"
    new_short = Database.Link.get(url)
    [back_url, clicks] = Database.Link.from(new_short)
    assert back_url==url
  end

  test "save a link and remove it" do
    url = "https://www.appido.ir/fun"
    new_short = Database.Link.get(url)
    Database.Link.remove(url)
    assert Database.Link.from(new_short) == :not_found

  end


end
