defmodule StudyReminder.Study.Reminder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reminders" do
    field :name, :string
    field :reminder_enabled, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(reminder, attrs) do
    reminder
    |> cast(attrs, [:name, :reminder_enabled])
    |> validate_required([:name, :reminder_enabled])
  end
end
