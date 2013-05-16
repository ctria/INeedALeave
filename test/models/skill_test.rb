require 'test_helper'

class SkillTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "All skills fulfill min coverage" do
    Skill.all.each {|skill|
      assert skill.is_covered?(nil), "Skill " + skill.skill_type + ": " + skill.name + " doesn't fulfill min coverage"
    }
  end
end
