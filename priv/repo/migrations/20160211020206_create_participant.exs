defmodule SportsTeamGo.Repo.Migrations.CreateParticipant do
  use Ecto.Migration

  def change do
    create table(:participants) do
      add :team_id, references(:teams, on_delete: :nothing, type: :integer)
      add :game_id, references(:games, on_delete: :nothing, type: :integer)
      add :description, :string

      timestamps
    end
    create index(:participants, [:team_id])
    create index(:participants, [:game_id])

  end
end
