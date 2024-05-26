defmodule RpgCombat.Damage do
  @moduledoc """
  Inflict damage from one character to another.
  """

  def deal_damage(_attacker, target, damage) do
    new_health = max(0, target.health - damage)
    is_alive = new_health != 0

    %{target | health: new_health, alive: is_alive}
  end
end
