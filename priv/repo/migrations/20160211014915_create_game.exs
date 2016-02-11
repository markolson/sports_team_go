defmodule SportsTeamGo.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:games, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :start, :datetime
      add :end, :datetime

      timestamps
    end

  end
end
