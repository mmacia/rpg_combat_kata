defmodule RpgCombat.Heal do
  @moduledoc """
  Defines how to heal characters.
  """

  def heal(_healer, %{alive: false} = target, _value), do: target
  def heal(_healer, %{health: 1_000} = target, _value), do: target

  def heal(_healer, target, value) do
    new_health = min(1_000, target.health + value)
    %{target | health: new_health}
  end
end