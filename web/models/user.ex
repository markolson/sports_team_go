defmodule SportsTeamGo.User do
  use SportsTeamGo.Web, :model
  import Ecto.Query

  schema "users" do
    field :name, :string
    field :email, :string

    has_many :authorizations, SportsTeamGo.Authorization

    has_many :team_members, SportsTeamGo.TeamMember
    has_many :teams, through: [:team_members, :team]
    timestamps
  end

  @required_fields ~w(name email)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:email, ~r/@/)
  end

  def register_on_team(model, team) do
    alias SportsTeamGo.TeamMember
    TeamMember.changeset(%TeamMember{}, %{user_id: model.id, team_id: team.id})
    |> SportsTeamGo.Repo.insert
  end

  def accept_team(model, team) do
     membership = Repo.one(from tm in TeamMember, where: [user_id: ^model.id, team_id: ^team.id])
     TeamMember.changeset(membership, %{accepted: true}) |> Repo.update
  end

  def accepted_teams(model) do
    SportsTeamGo.Team
    |> join(:inner, [t], m in SportsTeamGo.TeamMember, t.id == m.team_id)
    |> where([t, m], m.accepted == true)
    |> SportsTeamGo.Repo.all
  end
end
