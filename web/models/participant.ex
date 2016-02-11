defmodule SportsTeamGo.Participant do
  use SportsTeamGo.Web, :model

  schema "participants" do
    belongs_to :team, SportsTeamGo.Team
    belongs_to :game, SportsTeamGo.Game
    field :description, :string

    timestamps
  end

  @required_fields ~w(team_id game_id)
  @optional_fields ~w(description)

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
