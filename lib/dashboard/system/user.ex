defmodule Dashboard.System.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Bcrypt

  schema "usuarios" do
    field :email, :string
    field :nome, :string
    field :password, :string
    field :role, :integer

    timestamps()
  end

  def changeset(user, %{"admin" => "admin"}) do
    user
    |> cast(%{emal: "admin@admin.admin", password: "password", nome: "admin", role: -1}, [:email, :password, :nome, :role])
    |> put_pass_hash()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :nome, :role])
    |> validate_required([:email, :password, :nome, :role])
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end

  defp put_pass_hash(changeset), do: changeset

end
