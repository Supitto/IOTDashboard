defmodule DashboardWeb.Dashboard.DashboardController do
    use DashboardWeb, :controller

    def index(conn, _params) do
        import Ecto.Query
        valores = Dashboard.Repo.all(Dashboard.Sensor.Log)
        render conn, "index.html", qtd_sensores: length(Dashboard.Repo.all(Dashboard.Sensor.Meta)), ultimos_valores: Enum.drop(valores,length(valores)-10), qtd_valores: length(valores)
    end
end