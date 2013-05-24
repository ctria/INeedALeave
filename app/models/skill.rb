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

  def available_members(date,person=nil)
    available_members =[]
    people_out=[]
    people_out << person.email if !person.nil?
    LeaveRequest.where(:date=>date).where('Status != "Rejected"').each { |leave|
      people_out << leave.requestor
    }
    if people_out.count > 0 then
      members.each {|member|
        available_members << member if people_out.index(member.email).nil?
      }
    else
      available_members = members
    end
    available_members
  end

  # is_covered? -> checks if skill is covered based on skill capacity
  # is_covered?(date) -> checks if skill is covered based a specific date
  # is_covered?(date,person) -> checks if skill is covered based a specific date and makes sure that person will be out
  def is_covered?(date=nil,person=nil)
    if capacity >= min_coverage
      if  available_members(date,person).count >= min_coverage
        true
      else
        false
      end
    else
      false
    end
  end
end
