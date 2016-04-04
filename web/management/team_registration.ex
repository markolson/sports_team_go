defmodule SportsTeamGo.Management.TeamRegistration do
  import Ecto.Query
  alias SportsTeamGo.{Team,TeamMember}
  alias SportsTeamGo.Repo

  def add_user_to_team(user, team) do
    %TeamMember{}
    |> TeamMember.changeset(%{user_id: user.id, team_id: team.id})
    |> Repo.insert
  end

  def accept_membership(user, team) do
     membership = Repo.one(from tm in TeamMember, where: [user_id: ^user.id, team_id: ^team.id])
     # TODO: fail if there's no membership
     membership |> TeamMember.changeset(%{accepted: true}) |> Repo.update
  end

end
