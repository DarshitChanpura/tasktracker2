defmodule TaskTracker2.Repo.Migrations.CreateTask do
  use Ecto.Migration

  def change do
    create table(:task) do
      add :title, :string, null: false
      add :description, :text, null: false
      add :completed, :boolean, default: false, null: false
      add :minutes, :integer, default: 0
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:task, [:user_id])
  end
end
