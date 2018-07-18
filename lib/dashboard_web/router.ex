defmodule DashboardWeb.Router do
  use DashboardWeb, :router


  defp put_dash(conn, params) do
    conn
    |> put_layout({DashboardWeb.LayoutView, "dashboard.html"})
  end

  pipeline :put_dashboard do
    plug :put_dash
  end

  defp check_admin(conn, _atributes) do
    conn
  end

  pipeline :ensure_admin do
    plug :check_admin
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug Dashboard.Auth.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DashboardWeb do
    pipe_through [:browser, :auth] # Use the default browser stack

    get "/", LoginController, :index
    post "/", LoginController, :login
    get "/recovery", LoginController, :recovery
    post "/recovery", LoginController, :recovery_post
    get "/logout", LoginController, :logout
  end

  scope "/dashboard", DashboardWeb.Dashboard do
    pipe_through [:browser, :auth, :ensure_auth, :put_dashboard]

    get "/", DashboardController, :index
    resources "/sensores", SensoresController, only: [:index, :show]
  end

  scope "/dashboard", DashboardWeb.Export, alias: SensorLogXlsx.Export do
    pipe_through [:browser, :auth, :ensure_auth, :put_dashboard]
    get "/export/sensores/:id", SensoresController, :export
    get "/export/sensores/", SensoresController, :export
  end

  scope "/dashboard/admin", DashboardWeb.Admin do
    pipe_through [:browser, :auth, :ensure_auth, :ensure_admin, :put_dashboard]

    resources "/usuarios", UserController
    get "/usuarios/:id/changepass", UserController, :pass
    resources "/sensores", SensoresController
  end

end