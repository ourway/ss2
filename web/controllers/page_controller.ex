

defmodule Ss2.PageController do
  use Ss2.Web, :controller


  def index(conn, _params) do
    json conn, %{
        :message => "Hello from SS2.IR API",
        :docs => "https://ss2.ir/W4RN",
        :copyright => "Farsheed Ashouri ashouri <at> RASHAVAS <dot> COM"
      }
  end


  def code_redirect(conn, params ) do
    code = params["code"]
    conn = case Database.Link.from_code(code) do
      :not_found ->
        json conn, %{:message => :not_found}

      [link, clicks] ->
        redirect conn, external: link
    end
  end


end

