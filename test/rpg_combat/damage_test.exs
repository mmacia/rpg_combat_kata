defmodule RpgCombat.DamageTest do
  use ExUnit.Case, async: true

  alias RpgCombat.Character
  alias RpgCombat.Damage

  describe "deal_damage/3" do
    test "should substract damage from health" do
      attacker = Character.new()
      target = Character.new()

      target = Damage.deal_damage(attacker, target, 50)
      assert target.health == 950
    end

    test "when damage received exceeds current Health, Health becomes 0 and the character dies" do
      attacker = Character.new()
      target = Character.new()

      target = Damage.deal_damage(attacker, target, 5_000)
      assert Character.dead?(target)
      assert target.health == 0
    end
  end
end
