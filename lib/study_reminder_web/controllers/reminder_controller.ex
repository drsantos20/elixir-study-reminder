defmodule StudyReminderWeb.ReminderController do
  use StudyReminderWeb, :controller

  alias StudyReminder.Study
  alias StudyReminder.Study.Reminder

  action_fallback StudyReminderWeb.FallbackController

  def index(conn, _params) do
    reminders = Study.list_reminders()
    render(conn, "index.json", reminders: reminders)
  end

  def create(conn, %{"reminder_enabled" => reminder_enabled}) do
    account = conn.assigns.current_user
    IO.inspect(account)
    with {:ok, user, reminder} <- account |> Study.add_reminder(reminder_enabled) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.reminder_path(conn, :show, reminder))
      |> render("show.json", reminder: reminder)
    end
  end

  def show(conn, %{"id" => id}) do
    reminder = Study.get_reminder!(id)
    render(conn, "show.json", reminder: reminder)
  end

  def update(conn, %{"id" => id, "reminder" => reminder_params}) do
    reminder = Study.get_reminder!(id)

    with {:ok, %Reminder{} = reminder} <- Study.update_reminder(reminder, reminder_params) do
      render(conn, "show.json", reminder: reminder)
    end
  end

  def delete(conn, %{"id" => id}) do
    reminder = Study.get_reminder!(id)

    with {:ok, %Reminder{}} <- Study.delete_reminder(reminder) do
      send_resp(conn, :no_content, "")
    end
  end
end
