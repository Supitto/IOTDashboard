defmodule DashboardWeb.SensorOutChannel do
    use Phoenix.Channel

    def join("sensor_out:"<>sensor_id, _message, socket) do
        {:ok, socket}
    end

    def handle_in("out_value", _message, socket) do
        {:noreply, socket}
    end
    
    intercept ["out_value"]

    def handle_out("out_value", _message, socket) do
        {:noreply, socket}
    end

end