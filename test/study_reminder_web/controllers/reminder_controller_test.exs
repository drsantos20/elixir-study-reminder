defmodule StudyReminderWeb.ReminderControllerTest do
  use StudyReminderWeb.ConnCase

  alias StudyReminder.Study
  alias StudyReminder.Study.Reminder

  @create_attrs %{
    name: "some name",
    reminder_enabled: true
  }
  @update_attrs %{
    name: "some updated name",
    reminder_enabled: false
  }
  @invalid_attrs %{name: nil, reminder_enabled: nil}

  def fixture(:reminder) do
    {:ok, reminder} = Study.create_reminder(@create_attrs)
    reminder
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all reminders", %{conn: conn} do
      conn = get(conn, Routes.reminder_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create reminder" do
    test "renders reminder when data is valid", %{conn: conn} do
      conn = post(conn, Routes.reminder_path(conn, :create), reminder: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.reminder_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name",
               "reminder_enabled" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.reminder_path(conn, :create), reminder: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end


  defp create_reminder(_) do
    reminder = fixture(:reminder)
    {:ok, reminder: reminder}
  end
end
