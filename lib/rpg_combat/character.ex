defmodule RpgCombat.Character do
  @moduledoc """
  Defines the properties of a character.
  """

  alias UUID

  @max_ranges %{
    melee: 2,
    ranger: 20
  }

  defstruct id: nil,
            health: 1_000,
            level: 1,
            alive: true,
            max_range: 2,
            type: :melee

  def new(opts \\ []) do
    %__MODULE__{}
    |> Map.put(:id, UUID.uuid4())
    |> maybe_update_health(opts)
    |> maybe_update_level(opts)
    |> maybe_update_type(opts)
  end

  def alive?(character), do: character.alive

  def dead?(character), do: !character.alive

  defp maybe_update_health(character, opts) do
    health = Keyword.get(opts, :health)
    is_alive = health && health > 0

    if health, do: %{character | health: health, alive: is_alive}, else: character
  end

  defp maybe_update_level(character, opts) do
    level = Keyword.get(opts, :level)

    if level, do: %{character | level: level}, else: character
  end

  defp maybe_update_type(character, opts) do
    type = Keyword.get(opts, :type)

    if type do
      max_range = @max_ranges[type]

      %{character | type: type, max_range: max_range}
    else
      character
    end
  end
end
