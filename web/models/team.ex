defmodule SportsTeamGo.Team do
  use SportsTeamGo.Web, :model

  schema "teams" do
    field :name, :string

    has_many :team_members, SportsTeamGo.TeamMember
    has_many :members, through: [:team_members, :user]
    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
