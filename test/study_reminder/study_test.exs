defmodule StudyReminder.StudyTest do
  use StudyReminder.DataCase

  alias StudyReminder.Study

  describe "reminders" do
    alias StudyReminder.Study.Reminder

    @valid_attrs %{name: "some name", reminder_enabled: true}
    @update_attrs %{name: "some updated name", reminder_enabled: false}
    @invalid_attrs %{name: nil, reminder_enabled: nil}

    def reminder_fixture(attrs \\ %{}) do
      {:ok, reminder} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Study.create_reminder()

      reminder
    end

    test "list_reminders/0 returns all reminders" do
      reminder = reminder_fixture()
      assert Study.list_reminders() == [reminder]
    end

    test "get_reminder!/1 returns the reminder with given id" do
      reminder = reminder_fixture()
      assert Study.get_reminder!(reminder.id) == reminder
    end

    test "create_reminder/1 with valid data creates a reminder" do
      assert {:ok, %Reminder{} = reminder} = Study.create_reminder(@valid_attrs)
      assert reminder.name == "some name"
      assert reminder.reminder_enabled == true
    end

    test "create_reminder/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Study.create_reminder(@invalid_attrs)
    end

    test "update_reminder/2 with valid data updates the reminder" do
      reminder = reminder_fixture()
      assert {:ok, %Reminder{} = reminder} = Study.update_reminder(reminder, @update_attrs)
      assert reminder.name == "some updated name"
      assert reminder.reminder_enabled == false
    end

    test "update_reminder/2 with invalid data returns error changeset" do
      reminder = reminder_fixture()
      assert {:error, %Ecto.Changeset{}} = Study.update_reminder(reminder, @invalid_attrs)
      assert reminder == Study.get_reminder!(reminder.id)
    end

    test "delete_reminder/1 deletes the reminder" do
      reminder = reminder_fixture()
      assert {:ok, %Reminder{}} = Study.delete_reminder(reminder)
      assert_raise Ecto.NoResultsError, fn -> Study.get_reminder!(reminder.id) end
    end

    test "change_reminder/1 returns a reminder changeset" do
      reminder = reminder_fixture()
      assert %Ecto.Changeset{} = Study.change_reminder(reminder)
    end
  end
end
