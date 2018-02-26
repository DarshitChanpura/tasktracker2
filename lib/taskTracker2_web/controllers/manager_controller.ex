defmodule TaskTracker2Web.ManagerController do
  use TaskTracker2Web, :controller

  alias TaskTracker2.Accounts
  alias TaskTracker2.Accounts.Manager

  action_fallback TaskTracker2Web.FallbackController

  def index(conn, _params) do
    managers = Accounts.list_managers()
    render(conn, "index.json", managers: managers)
  end

  def create(conn, %{"manager" => manager_params}) do
    with {:ok, %Manager{} = manager} <- Accounts.create_manager(manager_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", manager_path(conn, :show, manager))
      |> render("show.json", manager: manager)
    end
  end

  def show(conn, %{"id" => id}) do
    manager = Accounts.get_manager!(id)
    render(conn, "show.json", manager: manager)
  end

  def update(conn, %{"id" => id, "manager" => manager_params}) do
    manager = Accounts.get_manager!(id)

    with {:ok, %Manager{} = manager} <- Accounts.update_manager(manager, manager_params) do
      render(conn, "show.json", manager: manager)
    end
  end

  def delete(conn, %{"id" => id}) do
    manager = Accounts.get_manager!(id)
    with {:ok, %Manager{}} <- Accounts.delete_manager(manager) do
      send_resp(conn, :no_content, "")
    end
  end
end
