defmodule Ss2.Router do
  use Ss2.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Ss2 do
    pipe_through :api

    get "/ping", ApiController, :ping

  end
end
