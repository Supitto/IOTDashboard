defmodule DashboardWeb.Export.SensoresController do
    use DashboardWeb, :controller
  
    alias Dashboard.Sensor.Log
    alias Dashboard.Repo

    def export(conn, %{"id" => id, "b" => b, "e" => e}) do
        text conn, id<>" "<>b<>" "<>e
    end
    
    def export(conn, %{"id" => id}) do
        text conn, id
    end

    def export(conn, %{"b" => b, "e" => e}) do
        text conn, b<>" "<>e
    end

    def export(conn, _params) do
        logs =
        Log
      |> Repo.all

    conn
    |> put_resp_content_type("text/xlsx")
    |> put_resp_header("content-disposition", "attachment; filename=relatorio_sensores.xlsx")
    |> render("report.xlsx", %{logs: logs})
    end
    
end