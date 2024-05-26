defmodule RpgCombat.Character do
  @moduledoc """
  Defines the properties of a character.
  """

  defstruct health: 1_000,
            level: 1,
            alive: true

  def new(opts \\ []) do
    %__MODULE__{}
    |> maybe_update_health(opts)
  end

  def alive?(character), do: character.alive

  def dead?(character), do: !character.alive

  defp maybe_update_health(character, opts) do
    health = Keyword.get(opts, :health)
    is_alive = health && health > 0

    if health, do: %{character | health: health, alive: is_alive}, else: character
  end
end
