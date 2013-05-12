class LeaveRequest < ActiveRecord::Base
  validates_presence_of :requestor
  validates_uniqueness_of :requestor, :scope=> [:date]
  validate :valid_person
  validate :skill_coverage

  def person
    Person.find_by_email(requestor)
  end

  # validations
  def valid_person
    errors.add(:requestor, "is not valid") if person.nil?
  end

  def skill_coverage
    if person
      person.langs.each {|lang|
        errors.add(:skill, "Language #{lang} is not covered") if (Skill.where(:skill_type=> "Language",:name =>lang)[0] and not (Skill.where(:skill_type=> "Language",:name =>lang)[0].is_covered?(date)))
      }
      person.sbrs.each {|sbr|
        errors.add(:skill, "SBR #{sbr} is not covered") if (Skill.where( :skill_type=> "SBR",:name =>sbr)[0] and not (Skill.where( :skill_type=> "SBR",:name =>sbr)[0].is_covered?(date)))
      }
    end
  end
end
