defmodule TaskTracker2Web.TimeBlocksView do
  use TaskTracker2Web, :view
  alias TaskTracker2Web.TimeBlocksView

  def render("index.json", %{timespent: timespent}) do
    %{data: render_many(timespent, TimeBlocksView, "time_blocks.json")}
  end

  def render("show.json", %{time_blocks: time_blocks}) do
    %{data: render_one(time_blocks, TimeBlocksView, "time_blocks.json")}
  end

  def render("time_blocks.json", %{time_blocks: time_blocks}) do
    %{id: time_blocks.id,
      start_time: time_blocks.start_time,
      end_time: time_blocks.end_time}
  end
end
