defmodule DashboardWeb.LoginController do
  use DashboardWeb, :controller

  alias Dashboard.Auth
  alias Dashboard.System.User
  alias Dashboard.Auth.Guardian
  alias Dashboard.Email
  alias Dashboard.Mailer

  def index(conn, _params) do
    
    changeset = User.changeset(%User{},%{})
    maybe_user = Guardian.Plug.current_resource(conn)
    case maybe_user do
      nil -> render(conn, "index.html")
      _-> redirect(conn, to: "/dashboard")
    end
  end

  def login(conn, %{"login" => %{"email" => email, "password" => senha}} = params) do
    {status, user} = Auth.authenticate_user(email, senha)
    login_reply({status, user}, conn)
  end

    defp login_reply({:error, error}, conn) do
    conn
    |> put_flash(:error, error)
    |> redirect(to: "/")
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:success, "Welcome back!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: "/")
  end

  def logout(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/")
  end

  def recovery(conn, _params) do
    conn
    |> render("recovery.html")
  end

  def recovery_post(conn, params) do
    Email.recovery_email(params["recover"]["email"])
    |> Mailer.deliver_now()

    conn
    |> put_flash(:info, "Um email informando a situação foi enviado ao administrador")
    |> redirect(to: "/")
  end
end

