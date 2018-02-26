defmodule TaskTracker2.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker2.Accounts.User
  alias TaskTracker2.Accounts.Manager

  schema "users" do
    field :email, :string
    field :name, :string
    field :is_manager, :boolean


    has_many :manager_manages, Manager, foreign_key: :manager_id
    has_many :workers, through: [:manager_manages, :worker]

    has_many :worker_under, Manager, foreign_key: :worker_id
    has_many :managers, through: [:worker_under, :manager]

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :is_manager])
    |> validate_required([:email, :name, :is_manager])
  end
end
