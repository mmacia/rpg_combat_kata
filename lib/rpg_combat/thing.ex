defmodule RpgCombat.Thing do
  @moduledoc """
  Describe props
  """

  defstruct id: nil,
            health: 100,
            destroyed: false

  def new(opts \\ []) do
    %__MODULE__{}
    |> Map.put(:id, UUID.uuid4())
    |> maybe_update_health(opts)
  end

  def destroyed?(thing), do: thing.destroyed

  # private

  defp maybe_update_health(thing, opts) do
    health = Keyword.get(opts, :health)
    thing = if health, do: %{thing | health: health}, else: thing
    if thing.health == 0, do: %{thing | destroyed: true}, else: thing
  end
end
