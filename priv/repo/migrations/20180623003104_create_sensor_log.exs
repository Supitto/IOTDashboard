defmodule Dashboard.Repo.Migrations.CreateSensorLog do
  use Ecto.Migration

  def change do
    create table(:sensor_log) do
      add :value, :string
      add :sensor_id, references(:sensor, on_delete: :nothing)

      timestamps()
    end

    create index(:sensor_log, [:sensor_id])
  end
end
