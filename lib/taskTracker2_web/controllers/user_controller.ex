defmodule TaskTracker2Web.UserController do
  use TaskTracker2Web, :controller

  alias TaskTracker2.Accounts
  alias TaskTracker2.Accounts.User

  def index(conn, _params) do
    current_user = conn.assigns[:current_user]
    users = Accounts.list_users()
    managers = Accounts.manager_of(current_user.id)
    underlings = Accounts.list_underlings(current_user.id)
    render(conn, "index.html", users: users,
                               managers: managers,
                               underlings: underlings)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    #record_id = Accounts.works_under(id)
    managers = Accounts.works_under(id)
    underlings = Accounts.list_underlings(id)
    # if (man != nil) do
    #   manager = Accounts.get_user!(record_id.manager_id)
    #   managerName = manager.name
    # end
    render(conn, "show.html", user: user,
                              managers: managers,
                              underlings: underlings)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
