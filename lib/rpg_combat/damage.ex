defmodule RpgCombat.Damage do
  @moduledoc """
  Inflict damage from one character to another.
  """

  def deal_damage(%{id: attacker_id}, %{id: target_id} = target, _damage)
      when attacker_id == target_id,
      do: target

  def deal_damage(%{level: attacker_level} = attacker, %{level: target_level} = target, damage)
      when target_level >= attacker_level + 5,
      do: do_deal_damage(attacker, target, damage * 0.5)

  def deal_damage(%{level: attacker_level} = attacker, %{level: target_level} = target, damage)
      when target_level + 5 <= attacker_level,
      do: do_deal_damage(attacker, target, damage * 1.5)

  def deal_damage(attacker, target, damage), do: do_deal_damage(attacker, target, damage)

  defp do_deal_damage(_attacker, target, damage) do
    new_health = max(0, target.health - damage)
    is_alive = new_health != 0

    %{target | health: new_health, alive: is_alive}
  end
end
