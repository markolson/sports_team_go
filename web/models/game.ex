defmodule SportsTeamGo.Game do
  use SportsTeamGo.Web, :model

  schema "games" do
    field :start, Ecto.DateTime
    field :end, Ecto.DateTime
    belongs_to :home, SportsTeamGo.Team
    belongs_to :away, SportsTeamGo.Team

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
