defmodule DashboardWeb.Export.SensoresView do
  use DashboardWeb, :view


  alias Elixlsx.{Workbook, Sheet}

  
@header [
    "ID da Medição",
    "ID do Sensor",
    "Valor da Medição",
    "Data da Medição"
  ]

  def render("report.xlsx", %{logs: logs}) do
    report_generator(logs) 
    |> Elixlsx.write_to_memory("report.xlsx") 
    |> elem(1) 
    |> elem(1)
  end

  def report_generator(logs) do
    rows = logs |> Enum.map(&(row(&1)))
    %Workbook{sheets: [%Sheet{name: "Log dos Sensores", rows: [@header] ++ rows}]}
  end

  def row(log) do
    [
      log.id,
      log.sensor_id,
      log.value,
      log.inserted_at |> Date.to_string
    ]
  end
end