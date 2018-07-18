defmodule Dashboard.Sensor.Meta do
  use Ecto.Schema
  import Ecto.Changeset


  schema "sensor" do
    field :bio, :string
    field :local, :string
    field :nome, :string

    timestamps()
  end

  @doc false
  def changeset(meta, attrs) do
    meta
    |> cast(attrs, [:nome, :local, :bio])
    |> validate_required([:nome, :local, :bio])
    |> unique_constraint(:nome)
  end
end
