defmodule SportsTeamGo.Repo.Migrations.CreateAuthorization do
  use Ecto.Migration

  def change do
    create table(:authorizations) do
      add :provider, :string
      add :uid, :string
      add :token, :string
      add :refresh_token, :string
      add :expires_at, :integer
      add :user_id, references(:users, on_delete: :nothing, type: :integer)

      timestamps
    end

    create index(:authorizations, [:user_id])
    create index(:authorizations, [:provider, :uid], unique: true)
    create index(:authorizations, [:expires_at])
    create index(:authorizations, [:provider, :token])
  end
end
