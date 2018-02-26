defmodule TaskTracker2.Repo.Migrations.CreateTimespent do
  use Ecto.Migration

  def change do
    create table(:timespent) do
      add :start_time, :utc_datetime
      add :end_time, :utc_datetime
      add :task_id, references(:task, on_delete: :delete_all)

      timestamps()
    end

    create index(:timespent, [:task_id])
  end
end
