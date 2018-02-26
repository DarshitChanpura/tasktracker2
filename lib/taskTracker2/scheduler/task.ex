defmodule TaskTracker2.Scheduler.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker2.Scheduler.Task
  alias TaskTracker2.Scheduler.TimeBlocks

  schema "task" do
    field :completed, :boolean, default: false
    field :description, :string
    field :start_time, :utc_datetime
    field :stop_time, :utc_datetime
    field :title, :string
    belongs_to :user, TaskTracker2.Accounts.User

    has_many :timespent_entry, TimeBlocks, foreign_key: :task_id
    has_many :task_logs, through: [:timespent_entry, :task]

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :start_time,
                    :stop_time, :user_id])
    |> validate_required([:title, :description, :completed, :start_time,
                        :stop_time,  :user_id])
  end


end
