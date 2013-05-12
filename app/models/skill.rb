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

  def available_members(date)
    available_members =[]
    people_out=[]
    out_of_office_members = 0
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

  def is_covered?(date)
    if capacity > min_coverage
      if  available_members(date).count > min_coverage
        true
      else
        false
      end
    else
      false
    end
  end
end
