defmodule TaskTracker2Web.ManagerView do
  use TaskTracker2Web, :view
  alias TaskTracker2Web.ManagerView

  def render("index.json", %{managers: managers}) do
    %{data: render_many(managers, ManagerView, "manager.json")}
  end

  def render("show.json", %{manager: manager}) do
    %{data: render_one(manager, ManagerView, "manager.json")}
  end

  def render("manager.json", %{manager: manager}) do
    %{id: manager.id}
  end
end
