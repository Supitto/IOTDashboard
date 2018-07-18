defmodule DashboardWeb.Admin.UserController do
  use DashboardWeb, :controller
  
    alias Dashboard.Repo
    alias Dashboard.System.User

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.html", users: users
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: User.changeset(%User{},%{})
  end

  def edit(conn, %{"id" => id}) do
    render  conn, "edit.html", changeset: get_user_by_id(id), id: id
  end

  def create(conn, params) do
    %User{}
    |> User.changeset(params["user"])
    |> Repo.insert()
    
    conn
    |>redirect(to: "/dashboard/admin/usuarios/")
  end

  def update(conn, %{"id" => id, "user" => params}) do
    user = Repo.get(User, id)
    user = User.changeset(user, params)
    Repo.update(user)
    |> IO.puts
    
    conn
    |> redirect(to: "/dashboard/admin/usuarios")
  end

  def pass(conn, %{"id" => id}) do
    user = get_user_by_id id
    render  conn, "pass.html", changeset: user, id: id
  end


  #just a dirty wrapper
  defp get_user_by_id (id) do
    Repo.get(User, id)
    |> User.changeset(%{})
  end

end
