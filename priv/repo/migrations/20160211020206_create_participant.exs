defmodule SportsTeamGo.Repo.Migrations.CreateParticipant do
  use Ecto.Migration

  def change do
    create table(:participants, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :team_id, references(:teams, on_delete: :nothing, type: :binary_id)
      add :game_id, references(:games, on_delete: :nothing, type: :binary_id)
      add :description, :string

      timestamps
    end
    create index(:participants, [:team_id])
    create index(:participants, [:game_id])

  end
end
