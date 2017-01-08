
defmodule Ss2.ApiController do
  use Ss2.Web, :controller


  def ping(conn, _params) do
    json conn, %{:message => :pong}
  end



end

