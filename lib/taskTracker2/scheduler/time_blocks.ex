defmodule TaskTracker2.Scheduler.TimeBlocks do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker2.Scheduler.TimeBlocks
  alias TaskTracker2.Scheduler.Task


  schema "timespent" do
    field :end_time, :utc_datetime
    field :start_time, :utc_datetime
    belongs_to :task, Task

    timestamps()
  end

  @doc false
  def changeset(%TimeBlocks{} = time_blocks, attrs) do
    time_blocks
    |> cast(attrs, [:start_time, :end_time, :task_id])
    |> validate_required([:start_time, :end_time, :task_id])
  end
end
