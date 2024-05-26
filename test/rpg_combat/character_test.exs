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
end
