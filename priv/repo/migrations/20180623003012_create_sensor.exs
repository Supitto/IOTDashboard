defmodule Dashboard.Repo.Migrations.CreateSensor do
  use Ecto.Migration

  def change do
    create table(:sensor) do
      add :nome, :string
      add :local, :text
      add :bio, :text

      timestamps()
    end

    create unique_index(:sensor, [:nome])
  end
end
