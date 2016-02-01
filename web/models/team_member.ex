defmodule SportsTeamGo.TeamMember do
  use SportsTeamGo.Web, :model

  schema "team_members" do
    field :accepted, :boolean, default: false
    belongs_to :team, SportsTeamGo.Team
    belongs_to :user, SportsTeamGo.User

    timestamps
  end

  @required_fields ~w(accepted)
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
