defmodule TaskTracker2.Repo.Migrations.AlterTask do
  use Ecto.Migration

  def change do
    alter table(:task) do
      remove :minutes
      add :start_time, :utc_datetime
      add :stop_time, :utc_datetime
    end
  end
end
