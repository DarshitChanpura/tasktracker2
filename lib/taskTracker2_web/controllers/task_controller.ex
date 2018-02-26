defmodule TaskTracker2Web.TaskController do
  use TaskTracker2Web, :controller

  alias TaskTracker2.Scheduler
  alias TaskTracker2.Scheduler.Task

  alias TaskTracker2.Accounts
  alias TaskTracker2.Accounts.User

  def index(conn, _params) do
    task = Scheduler.list_task()
    #tasks = Enum.reverse(Scheduler.feed_tasks_for(conn.assigns[:current_user]))
    render(conn, "index.html", task: task)
  end

  def new(conn, _params) do
    changeset = Scheduler.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    current_user = conn.assigns[:current_user]
    # #isValid = Accounts.manager_validity(current_user.id,
    # #                                String.to_integer(task_params["user_id"]))
    # #if isValid == [] do
    #   # adds a new error
    # #  updated_changeset = Ecto.Changeset.add_error(%Task{},
    #                                   :notManager, "Not a Manager",
    #                                   [additional: "info"])
    #   render(conn, "new.html",
    #                changeset: %{updated_changeset | action: :insert})
    # else
      case Scheduler.create_task(task_params) do
        {:ok, task} ->
          conn
          |> put_flash(:info, "Task created successfully.")
          |> redirect(to: task_path(conn, :show, task))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    #end
  end

  def show(conn, %{"id" => id}) do
    task = Scheduler.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Scheduler.get_task!(id)
    changeset = Scheduler.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Scheduler.get_task!(id)

    case Scheduler.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Scheduler.get_task!(id)
    {:ok, _task} = Scheduler.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: "/tasklist")
  end
end
