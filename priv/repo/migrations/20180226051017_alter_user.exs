defmodule TaskTracker2.Repo.Migrations.AlterUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :is_manager, :boolean
    end
  end
end
