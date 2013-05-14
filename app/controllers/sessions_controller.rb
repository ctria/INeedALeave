class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    my_session = Session.new(session_params)

    my_session.session_hash = rand(36**50).to_s(36)

    my_session.save

    Notifications.new_session(my_session.email,my_session.session_hash).deliver
    redirect_to root_url, notice: 'Session hash has been sent to your email'
  end

  def login
    my_session = Session.where(:session_hash=> params[:session_id])[0]
    print my_session.email
    if my_session && @current_user = Person.find_by_email(my_session.email)
      notice = 'You have logged in as: ' + @current_user.name
    else
      notice = 'This session hash was not found or it is no longer valid'
    end
    redirect_to root_url, notice: notice
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def session_params
    params.require(:session).permit(:email)
  end

end
