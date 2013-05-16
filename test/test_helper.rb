ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'active_resource/http_mock'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  def self.mock_people
    person1 = {:name=>"user1",:ircnick=>"nick1",:email=>"user1@example.com",:languages => "lang1", :sbrs=> "sbr1",:url=>"http://example.com/people/1.json"}
    person2 = {:name=>"user2",:ircnick=>"nick2",:email=>"user2@example.com",:languages => "lang2", :sbrs=> "sbr1",:url=>"http://example.com/people/1.json"}
    person3 = {:name=>"user3",:ircnick=>"nick3",:email=>"user3@example.com",:languages => "lang1,lang2", :sbrs=> "sbr1",:url=>"http://example.com/people/1.json"}
    person4 = {:name=>"user4",:ircnick=>"nick4",:email=>"user4@example.com",:languages => "lang1", :sbrs=> "sbr2",:url=>"http://example.com/people/1.json"}
    person5 = {:name=>"user5",:ircnick=>"nick5",:email=>"user5@example.com",:languages => "lang2", :sbrs=> "sbr2",:url=>"http://example.com/people/1.json"}
    person6 = {:name=>"user6",:ircnick=>"nick6",:email=>"user6@example.com",:languages => "lang1", :sbrs=> "sbr1,sbr2",:url=>"http://example.com/people/1.json"}
    person7 = {:name=>"user7",:ircnick=>"nick7",:email=>"user7@example.com",:languages => "lang2", :sbrs=> "sbr1,sbr2",:url=>"http://example.com/people/1.json"}
    person8 = {:name=>"user8",:ircnick=>"nick8",:email=>"user8@example.com",:languages => "lang1,lang2", :sbrs=> "",:url=>"http://example.com/people/1.json"}
    lang1_people = [person1,person3,person4,person6,person8]
    lang2_people = [person2,person3,person5,person7,person8]
    sbr1_people = [person1,person2,person3,person6,person7]
    sbr2_people = [person4,person5,person6,person7]
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get    "/people.json?sbr=sbr1",{}, sbr1_people.to_json
      mock.get    "/people.json?sbr=sbr2",{}, sbr2_people.to_json
      mock.get    "/people.json?language=lang1",{}, lang1_people.to_json
      mock.get    "/people.json?language=lang2",{}, lang2_people.to_json
      mock.get    "/people.json?email=user1%40example.com",{}, [person1].to_json
    end
  end

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
  mock_people

  # Add more helper methods to be used by all tests here...
end

