defmodule DashboardWeb.Dashboard.SensoresController do
    use DashboardWeb, :controller

    alias Dashboard.Repo
    alias Dashboard.Sensor.Meta
    alias Dashboard.Sensor.Log

    def index(conn, _params) do
        sensores = Repo.all(Meta)
        render conn, "index.html", sensores: sensores
    end

    def show(conn, %{"id" => id} = params) do
    import Ecto.Query
    sensor = Dashboard.Repo.one(from s in Dashboard.Sensor.Meta, where: s.id == ^id)
    ultimos_valores = Dashboard.Repo.all(from s in Dashboard.Sensor.Log, limit: 10, order_by: [desc: s.inserted_at])
    render conn, "show.html", sensor: sensor, ultimos_valores: ultimos_valores
    end
end