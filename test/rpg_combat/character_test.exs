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

    test "newly characters belongs to no faction" do
      subject = Character.new()
      assert subject.factions == MapSet.new()
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

  describe "join_faction/2" do
    test "should join to a faction" do
      character = Character.new()
      subject = Character.join_faction(character, :faction1)

      assert MapSet.member?(subject.factions, :faction1)
    end
  end

  describe "leave_faction/2" do
    test "should leave a faction" do
      character =
        Character.new()
        |> Character.join_faction(:faction1)

      subject = Character.leave_faction(character, :faction1)

      assert not MapSet.member?(subject.factions, :faction1)
    end
  end

  describe "allies?/2" do
    test "two characters with at least a faction in common are allies" do
      character1 =
        Character.new()
        |> Character.join_faction(:faction1)

      character2 =
        Character.new()
        |> Character.join_faction(:faction1)

      assert Character.allies?(character1, character2)
    end
  end
end
