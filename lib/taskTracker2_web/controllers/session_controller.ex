defmodule TaskTracker2Web.SessionController do
  use TaskTracker2Web, :controller

  def create(conn, %{"email" => email}) do
    user = TaskTracker2.Accounts.get_user_by_email(email)
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Welcome back, #{user.name}")
      |> redirect(to: "/tasklist")
    else
      conn
      |> put_flash(:error, "Can't create session")
      |> redirect(to: page_path(conn, :index))
    end

  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out successfully")
    |> redirect(to: page_path(conn, :index))
  end
end
