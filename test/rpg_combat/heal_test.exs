defmodule RpgCombat.HealTest do
  use ExUnit.Case, async: true

  alias RpgCombat.Character
  alias RpgCombat.Heal

  describe "heal/3" do
    test "dead characters should not be healed" do
      healer = Character.new(health: 0)
      target = healer

      target = Heal.heal(healer, target, 50)
      assert target.health == 0
      assert Character.dead?(target)
    end

    test "healing cannot raise health above 1000" do
      healer = Character.new()
      target = healer

      target = Heal.heal(healer, target, 5_000)
      assert target.health == 1_000
    end

    test "should heal a damaged character" do
      healer = Character.new(health: 200)
      target = healer

      target = Heal.heal(healer, target, 50)
      assert target.health == 250
    end

    test "a character cannot heal another character" do
      healer = Character.new()
      target = Character.new(health: 200)

      target = Heal.heal(healer, target, 50)
      assert target.health == 200
    end

    test "allied characters could heal each other" do
      healer =
        Character.new()
        |> Character.join_faction(:faction1)

      target =
        Character.new(health: 200)
        |> Character.join_faction(:faction1)

      target = Heal.heal(healer, target, 50)
      assert target.health == 250
    end
  end
end
