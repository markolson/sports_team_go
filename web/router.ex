defmodule SportsTeamGo.Router do
  use SportsTeamGo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SportsTeamGo do
    pipe_through [:browser, :browser_auth] # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/teams", TeamController
    delete "/logout", AuthController, :logout
  end

  scope "/auth", SportsTeamGo do
    pipe_through [:browser, :browser_auth]

    get "/:identity", AuthController, :login
    get "/:identity/callback", AuthController, :callback
    post "/:identity/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", SportsTeamGo do
  #   pipe_through :api
  # end
end
