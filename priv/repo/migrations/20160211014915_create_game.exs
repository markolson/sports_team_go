defmodule SportsTeamGo.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :start, :datetime
      add :end, :datetime

      timestamps
    end

  end
end
