class Skill < ActiveRecord::Base
  @my_members = nil

  def members
    if @my_members.nil?
      if skill_type == "Language"
        @my_members = Person.on_lang(name)
      elsif skill_type == "SBR"
        @my_members = Person.on_sbr(name)
      else
        @my_members = []
      end
    end
    @my_members
  end

  def capacity
    members.count
  end
end
