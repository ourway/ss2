defmodule Ss2.Router do
  use Ss2.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Ss2 do
    pipe_through :api
    get "/", PageController, :index
    get "/:code", PageController, :code_redirect
  end

  scope "/api", Ss2 do
    pipe_through :api

    get "/ping", ApiController, :ping
    post "/save", ApiController, :save

  end
end
