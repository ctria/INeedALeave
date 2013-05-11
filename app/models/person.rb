class Person < ActiveResource::Base
  self.site = "http://localhost:3001"
  self.element_name ="person"

  @who_to_notify = nil

  def self.on_sbr(sbr)
    self.where(:sbr=>sbr)
  end

  def self.on_lang(lang)
    self.where(:language=>lang)
  end

  def sbrs
    super.split(",")
  end

  def langs
    self.languages.split(",")
  end

  def who_to_notify
    if @who_to_notify.nil?
      @who_to_notify = []
      langs.each { |lang|
        Person.on_lang(lang).each { |person|
          @who_to_notify << person
        }
      }
      sbrs.each { |sbr|
        Person.on_sbr(sbr).each { |person|
          @who_to_notify << person
        }
      }
    end
    @who_to_notify
  end
end

