defmodule StudyReminderWeb.Router do
  use StudyReminderWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", StudyReminderWeb do
    pipe_through :api
  end
end
