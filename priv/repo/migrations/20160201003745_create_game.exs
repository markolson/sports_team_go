defmodule SportsTeamGo.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:games, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :start, :datetime
      add :end, :datetime
      add :home_id, references(:teams, on_delete: :nothing, type: :binary_id)
      add :away_id, references(:teams, on_delete: :nothing, type: :binary_id)

      timestamps
    end
    create index(:games, [:home_id])
    create index(:games, [:away_id])

  end
end