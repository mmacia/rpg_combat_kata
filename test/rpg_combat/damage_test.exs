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

    test "a character cannot deal damage to itself" do
      attacker = Character.new()
      target = attacker

      target = Damage.deal_damage(attacker, target, 50)
      assert target.health == 1_000
    end

    test "if the target is 5 or more Levels above the attacker, Damage is reduced by 50%" do
      attacker = Character.new()
      target = Character.new(level: 7)

      target = Damage.deal_damage(attacker, target, 100)
      assert target.health == 950
    end

    test "if the target is 5 or more Levels below the attacker, Damage is increased by 50%" do
      attacker = Character.new(level: 7)
      target = Character.new()

      target = Damage.deal_damage(attacker, target, 100)
      assert target.health == 850
    end
  end
end
