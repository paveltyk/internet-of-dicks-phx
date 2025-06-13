defmodule DicksWeb.Router do
  use DicksWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DicksWeb do
    pipe_through :api
  end
end
