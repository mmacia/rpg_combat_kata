defmodule RpgCombat.Damage do
  @moduledoc """
  Inflict damage from one character to another.
  """

  defmodule InvalidAttack do
    defexception [:message]
  end

  alias RpgCombat.Character
  alias RpgCombat.Thing

  def deal_damage(%Thing{}, _target, _attack),
    do: raise(InvalidAttack, message: "a thing could not attack deal damage")

  def deal_damage(%Character{id: attacker_id}, %{id: target_id} = target, _attack)
      when attacker_id == target_id,
      do: target

  def deal_damage(
        %Character{level: attacker_level} = attacker,
        %Character{level: target_level} = target,
        attack
      )
      when target_level >= attacker_level + 5,
      do: do_deal_damage(attacker, target, %{attack | points: attack.points * 0.5})

  def deal_damage(
        %Character{level: attacker_level} = attacker,
        %Character{level: target_level} = target,
        attack
      )
      when target_level + 5 <= attacker_level,
      do: do_deal_damage(attacker, target, %{attack | points: attack.points * 1.5})

  def deal_damage(%Character{} = attacker, target, damage),
    do: do_deal_damage(attacker, target, damage)

  # private

  defp do_deal_damage(%Character{max_range: max_range}, target, %{distance: distance})
       when distance > max_range,
       do: target

  defp do_deal_damage(%Character{} = attacker, %Character{} = target, %{points: points}) do
    if Character.allies?(attacker, target) do
      target
    else
      new_health = max(0, target.health - points)
      is_alive = new_health != 0

      %{target | health: new_health, alive: is_alive}
    end
  end

  defp do_deal_damage(%Character{} = _attacker, %Thing{} = target, %{points: points}) do
    new_health = max(0, target.health - points)
    is_destroyed = new_health == 0

    %{target | health: new_health, destroyed: is_destroyed}
  end
end
