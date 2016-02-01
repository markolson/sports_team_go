defmodule SportsTeamGo.Repo.Migrations.CreateTeamMember do
  use Ecto.Migration

  def change do
    create table(:team_members, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :accepted, :boolean, default: false
      add :team_id, references(:teams, on_delete: :nothing, type: :binary_id)
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps
    end
    create index(:team_members, [:team_id])
    create index(:team_members, [:user_id])

  end
end
