defmodule TaskTracker2Web.Router do
  use TaskTracker2Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :get_current_user
    plug :fetch_flash
    #plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  def get_current_user(conn, params) do
    user_id = get_session(conn, :user_id)
    if user_id do
      user = TaskTracker2.Accounts.get_user!(user_id)
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end

  scope "/", TaskTracker2Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/tasklist", PageController, :tasklist

    resources "/users", UserController
    resources "/task", TaskController

    post "/session", SessionController, :create
    delete "/session", SessionController, :delete
  end

  # Other scopes may use custom stacks.
   scope "/api/v1", TaskTracker2Web do
     pipe_through :api

     resources "/managers", ManagerController, except: [:new, :edit]
     resources "/timespent", TimeBlocksController, except: [:new, :edit]
   end
end
