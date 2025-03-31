defmodule LagerWeb.Router do
  use LagerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LagerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LagerWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/item_id", ItemsLive.Index, :index
    live "/item_id/new", ItemsLive.Index, :new
    live "/item_id/:id/edit", ItemsLive.Index, :edit

    live "/item_id/:id", ItemsLive.Show, :show
    live "/item_id/:id/show/edit", ItemsLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", LagerWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:lager, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LagerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
