defmodule StudyReminder.Study.Reminder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reminders" do
    field :name, :string
    field :reminder_enabled, :boolean, default: false
    belongs_to :user, StudyReminder.Accounts.User, foreign_key: :user_id

    timestamps()
  end

  @required_fields ~w(name user_id)a

  @doc false
  def changeset(reminder, attrs) do
    reminder
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
