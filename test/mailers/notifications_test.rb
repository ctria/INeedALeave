require 'test_helper'

class NotificationsTest < ActionMailer::TestCase
  test "new_session" do
    hash =  rand(36**50).to_s(36)
    mail_to = "to@example.org"
    mail = Notifications.new_session(mail_to, hash)
    assert_equal "New session hash", mail.subject
    assert_equal [mail_to], mail.to
    assert_equal [Rails.configuration.default_from], mail.from
    assert_match hash, mail.body.encoded
  end

end
