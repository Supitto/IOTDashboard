defmodule Dashboard.Repo.Migrations.CreateUsuarios do
  use Ecto.Migration

  def change do
    create table(:usuarios) do
      add :email, :string
      add :password, :string
      add :nome, :string
      add :role, :integer

      timestamps()
    end

    create unique_index(:usuarios, [:email])
  end
end
