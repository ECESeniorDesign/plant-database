defmodule Backend.Router do
  use Backend.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Backend, as: :api do
    pipe_through :api
    post "/token", TokenController, :create
    post "/notify", NotificationController, :notify
    get "/plants", PlantController, :index
    get "/plants/:id", PlantController, :show
    post "/plants/compatible", PlantController, :compatible
    post "/devices", DeviceController, :create
    post "/notification_settings", NotificationSettingController, :update
  end

  scope "/", Backend do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/registration", RegistrationController, :new
    post "/registration", RegistrationController, :create

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/login", SessionController, :delete
  end

  scope "/admin", Backend do
    pipe_through :browser # Use the default browser stack

    resources "/plants", Admin.PlantController    
  end

  # Other scopes may use custom stacks.
  # scope "/api", Backend do
  #   pipe_through :api
  # end
end
