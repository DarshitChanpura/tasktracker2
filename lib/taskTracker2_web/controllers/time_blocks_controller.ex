defmodule TaskTracker2Web.TimeBlocksController do
  use TaskTracker2Web, :controller

  alias TaskTracker2.Scheduler
  alias TaskTracker2.Scheduler.TimeBlocks

  action_fallback TaskTracker2Web.FallbackController

  def index(conn, _params) do
    timespent = Scheduler.list_timespent()
    render(conn, "index.json", timespent: timespent)
  end

  def create(conn, %{"time_blocks" => time_blocks_params}) do
    with {:ok, %TimeBlocks{} = time_blocks} <- Scheduler.create_time_blocks(time_blocks_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", time_blocks_path(conn, :show, time_blocks))
      |> render("show.json", time_blocks: time_blocks)
    end
  end

  def show(conn, %{"id" => id}) do
    time_blocks = Scheduler.get_time_blocks!(id)
    render(conn, "show.json", time_blocks: time_blocks)
  end

  def update(conn, %{"id" => id, "time_blocks" => time_blocks_params}) do
    time_blocks = Scheduler.get_time_blocks!(id)

    with {:ok, %TimeBlocks{} = time_blocks} <- Scheduler.update_time_blocks(time_blocks, time_blocks_params) do
      render(conn, "show.json", time_blocks: time_blocks)
    end
  end

  def delete(conn, %{"id" => id}) do
    time_blocks = Scheduler.get_time_blocks!(id)
    with {:ok, %TimeBlocks{}} <- Scheduler.delete_time_blocks(time_blocks) do
      send_resp(conn, :no_content, "")
    end
  end
end
