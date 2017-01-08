
defmodule Ss2.ApiController do
  use Ss2.Web, :controller


  def ping(conn, _params) do
    json conn, %{:message => :pong}
  end


    def save(conn, params) do
    case params["link"] do
      nil ->
        json conn, %{:message => :link_not_found}
      link ->
        shortlink = Database.Link.get(link)
        json conn, %{:shortlink => shortlink}
    end
  end



end

