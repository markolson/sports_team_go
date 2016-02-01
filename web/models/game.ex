defmodule SportsTeamGo.Game do
  use SportsTeamGo.Web, :model

  schema "games" do
    field :start, Ecto.DateTime
    field :end, Ecto.DateTime
    field :home_id, Ecto.UUID
    field :away_id, Ecto.UUID
    belongs_to :home_team, SportsTeamGo.Team, foreign_key: :home_id, define_field: false, type: Ecto.UUID
    belongs_to :away_team, SportsTeamGo.Team, foreign_key: :away_id, define_field: false, type: Ecto.UUID

    timestamps
  end

  @required_fields ~w(start end)
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
