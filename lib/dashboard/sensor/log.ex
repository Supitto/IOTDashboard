defmodule Dashboard.Sensor.Log do
  use Ecto.Schema
  import Ecto.Changeset


  schema "sensor_log" do
    field :value, :string
    field :sensor_id, :id

    timestamps()
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
