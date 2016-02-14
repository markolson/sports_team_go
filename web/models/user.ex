defmodule SportsTeamGo.User do
  use SportsTeamGo.Web, :model
  import Ecto.Query
  alias SportsTeamGo.Team
  alias SportsTeamGo.TeamMember
  alias SportsTeamGo.Repo

  schema "users" do
    field :name, :string
    field :email, :string

    has_many :authorizations, SportsTeamGo.Authorization

    has_many :team_members, TeamMember
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
    %TeamMember{}
    |> TeamMember.changeset(%{user_id: model.id, team_id: team.id})
    |> Repo.insert
  end

  def accept_team(model, team) do
     membership = Repo.one(from tm in TeamMember, where: [user_id: ^model.id, team_id: ^team.id])
     # TODO: fail if there's no membership
     membership |> TeamMember.changeset(%{accepted: true}) |> Repo.update
  end

  def accepted_teams(model) do
    Team
    |> join(:inner, [t], m in TeamMember, t.id == m.team_id)
    |> where([t, m], m.accepted == true)
    |> where([t, m], m.user_id == ^model.id)
    |> Repo.all
  end
end
