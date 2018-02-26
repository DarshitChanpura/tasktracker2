defmodule TaskTracker2.Scheduler do
  @moduledoc """
  The Scheduler context.
  """

  import Ecto.Query, warn: false
  alias TaskTracker2.Repo

  alias TaskTracker2.Scheduler.Task

  @doc """
  Returns the list of task.

  ## Examples

      iex> list_task()
      [%Task{}, ...]

  """
  def list_task do
    Repo.all(Task)
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id) do
    Repo.get!(Task, id)
    |> Repo.preload(:user)
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end

  def feed_tasks_for(user) do
    user = Repo.preload(user, :workers)
    worker_ids = Enum.map(user.workers, &(&1.id))

    Repo.all(Task)
    |> Enum.filter(&(Enum.member?(worker_ids, &1.user_id)))
    |> Repo.preload(:user)
  end


  alias TaskTracker2.Scheduler.TimeBlocks

  def show_updated_task(task_id) do
    Repo.all(from t in TimeBlocks,
    where: t.task_id == ^task_id)
    |> Enum.map(&{Repo.get!(Task, &1.task_id)})
  end

  @doc """
  Returns the list of timespent.

  ## Examples

      iex> list_timespent()
      [%TimeBlocks{}, ...]

  """
  def list_timespent do
    Repo.all(TimeBlocks)
  end

  @doc """
  Gets a single time_blocks.

  Raises `Ecto.NoResultsError` if the Time blocks does not exist.

  ## Examples

      iex> get_time_blocks!(123)
      %TimeBlocks{}

      iex> get_time_blocks!(456)
      ** (Ecto.NoResultsError)

  """
  def get_time_blocks!(id), do: Repo.get!(TimeBlocks, id)

  @doc """
  Creates a time_blocks.

  ## Examples

      iex> create_time_blocks(%{field: value})
      {:ok, %TimeBlocks{}}

      iex> create_time_blocks(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_time_blocks(attrs \\ %{}) do
    %TimeBlocks{}
    |> TimeBlocks.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a time_blocks.

  ## Examples

      iex> update_time_blocks(time_blocks, %{field: new_value})
      {:ok, %TimeBlocks{}}

      iex> update_time_blocks(time_blocks, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_time_blocks(%TimeBlocks{} = time_blocks, attrs) do
    time_blocks
    |> TimeBlocks.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TimeBlocks.

  ## Examples

      iex> delete_time_blocks(time_blocks)
      {:ok, %TimeBlocks{}}

      iex> delete_time_blocks(time_blocks)
      {:error, %Ecto.Changeset{}}

  """
  def delete_time_blocks(%TimeBlocks{} = time_blocks) do
    Repo.delete(time_blocks)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking time_blocks changes.

  ## Examples

      iex> change_time_blocks(time_blocks)
      %Ecto.Changeset{source: %TimeBlocks{}}

  """
  def change_time_blocks(%TimeBlocks{} = time_blocks) do
    TimeBlocks.changeset(time_blocks, %{})
  end
end
