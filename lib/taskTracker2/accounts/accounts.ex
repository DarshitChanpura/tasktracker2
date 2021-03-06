defmodule TaskTracker2.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias TaskTracker2.Repo

  alias TaskTracker2.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
    |> Repo.preload(:managers)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
     Repo.get!(User, id)
     |> Repo.preload(:managers)
  end

  def get_user_by_email(email) do
     Repo.get_by(User, email: email)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias TaskTracker2.Accounts.Manager

  @doc """
  Returns the list of managers.

  ## Examples

      iex> list_managers()
      [%Manager{}, ...]

  """
  def list_managers do
    Repo.all(Manager)
  end

  def manager_of(user_id) do
    Repo.all(from m in Manager,
    where: m.manager_id == ^user_id)
    |> Enum.map(&{&1.worker_id, &1.id})
    |> Enum.into(%{})
  end

  def works_under(user_id) do
    Repo.all(from m in Manager,
    where: m.worker_id == ^user_id)
    |> Enum.map(&{Repo.get!(User, &1.manager_id).name})
  end

  def underlings(user_id) do
    Repo.all(from m in Manager,
    where: m.manager_id == ^user_id)
    |> Enum.map(&{Repo.get!(User, &1.worker_id).name, Repo.get!(User, &1.worker_id).id})
    |> Enum.into(%{})
  end

  def get_managers(user_id) do
    Repo.all(from m in Manager,
    where: m.worker_id == ^user_id)
    |> Enum.map(&{Repo.get!(User, &1.manager_id)})
  end

  def list_underlings(user_id) do
    Repo.all(from m in Manager,
    where: m.manager_id == ^user_id)
    |> Enum.map(&{Repo.get!(User, &1.worker_id).name})

  end

  def manager_validity(curr_user_id, user_id) do
    Repo.all(from m in Manager, where: m.manager_id == ^curr_user_id
                                and m.worker_id == ^user_id)
  end


  @doc """
  Gets a single manager.

  Raises `Ecto.NoResultsError` if the Manager does not exist.

  ## Examples

      iex> get_manager!(123)
      %Manager{}

      iex> get_manager!(456)
      ** (Ecto.NoResultsError)

  """
  def get_manager!(id), do: Repo.get!(Manager, id)

  @doc """
  Creates a manager.

  ## Examples

      iex> create_manager(%{field: value})
      {:ok, %Manager{}}

      iex> create_manager(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_manager(attrs \\ %{}) do
    %Manager{}
    |> Manager.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a manager.

  ## Examples

      iex> update_manager(manager, %{field: new_value})
      {:ok, %Manager{}}

      iex> update_manager(manager, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_manager(%Manager{} = manager, attrs) do
    manager
    |> Manager.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Manager.

  ## Examples

      iex> delete_manager(manager)
      {:ok, %Manager{}}

      iex> delete_manager(manager)
      {:error, %Ecto.Changeset{}}

  """
  def delete_manager(%Manager{} = manager) do
    Repo.delete(manager)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking manager changes.

  ## Examples

      iex> change_manager(manager)
      %Ecto.Changeset{source: %Manager{}}

  """
  def change_manager(%Manager{} = manager) do
    Manager.changeset(manager, %{})
  end
end
