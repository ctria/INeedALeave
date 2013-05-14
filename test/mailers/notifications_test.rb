require 'test_helper'

class NotificationsTest < ActionMailer::TestCase
  test "new_session" do
    mail = Notifications.new_session
    assert_equal "New session", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
