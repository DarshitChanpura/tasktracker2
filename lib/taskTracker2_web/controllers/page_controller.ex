defmodule TaskTracker2Web.PageController do
  use TaskTracker2Web, :controller

  alias TaskTracker2.Scheduler
  alias TaskTracker2.Scheduler.Task

  def index(conn, _params) do
    render conn, "index.html"
  end

  def tasklist(conn, _params) do
    #tasks = Scheduler.list_task()
    tasks = Enum.reverse(Scheduler.feed_tasks_for(conn.assigns[:current_user]))
    changeset = Scheduler.change_task(%Task{})
    render conn, "tasklist.html", tasks: tasks, changeset: changeset
  end
end
