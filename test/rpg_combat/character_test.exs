defmodule RpgCombat.CharacterTest do
  use ExUnit.Case, async: true

  alias RpgCombat.Character

  describe "new/1" do
    test "health should start at 1000" do
      subject = Character.new()
      assert subject.health == 1_000
    end

    test "level should start at 1" do
      subject = Character.new()
      assert subject.level == 1
    end

    test "should be start as live" do
      subject = Character.new()
      assert Character.alive?(subject)
    end
  end

  describe "max_range/0" do
    test "melee fighters have a range of 2" do
      subject = Character.new(type: :melee)
      assert subject.max_range == 2
    end

    test "ranger fighters have a range of 20" do
      subject = Character.new(type: :ranger)
      assert subject.max_range == 20
    end
  end
end
