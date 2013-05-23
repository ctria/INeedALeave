class Notifications < ActionMailer::Base
  default :from => Rails.configuration.default_from
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.new_session.subject
  #
  def new_session(email,session_hash)
    @hash = session_hash

    mail to: email, subject: "New session hash"
  end
end
