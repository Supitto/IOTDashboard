defmodule DashboardWeb.SensorInChannel do
    use Phoenix.Channel

    #HUGE SECURITY FLAW
    def join("sensor_in", _in_metadata, socket) do
        import Ecto.Query
        
        {:ok, socket}
    end

    def handle_in("new_value", %{"sensor_name"=>nome,"value"=>value} = message, socket) do
        import Ecto.Query
        meta_sensor = Dashboard.Repo.one(from s in Dashboard.Sensor.Meta, where: s.nome == ^nome)
        changeset = Dashboard.Sensor.Log.changeset(%Dashboard.Sensor.Log{},%{value: to_string(value), meta_sensor_id: meta_sensor.id})
        case Dashboard.Repo.insert(changeset,[]) do
            {:ok, _} -> 
                broadcast socket, "new_value", message
                {:reply, :thanks, socket}
            {:error, c} -> IO.puts c
                            {:reply, :deu_ruim, socket}

        end
    end


#    def join("sensor_in", %{"sensor_name" => name} = in_metadata, socket) do
#        import Ecto.Query
#        
#        sensor = Dashboard.Repo.one(from s in Dashboard.Sensor.Meta, where: s.name == ^name)
#        {:ok, %{socket| assigns: %{id: sensor.id}}}
#    end
#
#    def handle_in("new_value", %{"value"=>value} = message, socket) do
#        changeset = Dashboard.Sensor.Log.changeset(%Dashboard.Sensor.Log{},%{value: to_string(value), meta_sensor_id: socket.assigns.id})
#        case Dashboard.Repo.insert(changeset,[]) do
#            {:ok, _} -> 
#                broadcast socket, "new_value", message
#                {:reply, :thanks, socket}
#            {:error, c} -> IO.puts c
#                            {:reply, :deu_ruim, socket}
#
#        end
#    end

end