defmodule RpgCombat.Heal do
  @moduledoc """
  Defines how to heal characters.
  """
  alias RpgCombat.Character

  def heal(_healer, %{alive: false} = target, _value), do: target
  def heal(_healer, %{health: 1_000} = target, _value), do: target

  def heal(%{id: healer_id} = healer, %{id: target_id} = target, value)
      when healer_id == target_id,
      do: do_heal(healer, target, value)

  def heal(healer, target, value) do
    if Character.allies?(healer, target) do
      do_heal(healer, target, value)
    else
      target
    end
  end

  # private

  defp do_heal(_healer, target, value) do
    new_health = min(1_000, target.health + value)
    %{target | health: new_health}
  end
end
