defmodule TaskTracker2.Accounts.Manager do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker2.Accounts.Manager

  alias TaskTracker2.Accounts.User

  schema "managers" do
    belongs_to :manager, User
    belongs_to :worker, User

    timestamps()
  end

  @doc false
  def changeset(%Manager{} = manager, attrs) do
    manager
    |> cast(attrs, [:manager_id, :worker_id])
    |> validate_required([:manager_id, :worker_id])
  end
end
