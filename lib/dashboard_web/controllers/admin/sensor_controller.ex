defmodule DashboardWeb.Admin.SensoresController do
  use DashboardWeb, :controller
  
    alias Dashboard.Repo
    alias Dashboard.Sensor.Meta

  def index(conn, _params) do
    metas = Repo.all(Meta)
    render conn, "index.html", sensores: metas
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: Meta.changeset(%Meta{},%{})
  end

  def edit(conn, %{"id" => id}) do
    meta = Repo.get(Meta, id)
    meta2 = Meta.changeset(meta,%{})
    render  conn, "edit.html", changeset: meta2, id: id
  end

  def create(conn, params) do
    Repo.insert(Meta.changeset(%Meta{},params["meta"]))
    conn
    |>redirect(to: "/dashboard/admin/sensores/")
  end

  def update(conn, params) do
    Meta.changeset(%Meta{},params["meta"])
    |> Repo.update
    conn
    |> redirect(to: "/dashboard/admin/sensores")
  end

end
