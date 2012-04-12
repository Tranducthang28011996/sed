class SessionsController < ApplicationController
  #SPEC: 1.1.3: Login Ability
  #SPEC: 3.1: Advisor Login Ability
  def new
  end

  #SPEC: 1.1.4: Goes to the appropriate screen
  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to root_url, notice: "Logged In!"
    else
      flash.now.alert = "Invalid Credentials"
      render "new"
    end
  end

  #SPEC: 1.1.6: Logout Ability
  #SPEC: 2.3 Log Out
  #SPEC: 3.2: Advisor Logout Ability
  def destroy
    cookies.delete(:auth_token)
    reset_session
    redirect_to root_path, notice: "Logged Out"
  end
end
