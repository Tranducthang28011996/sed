class SessionsController < ApplicationController
  #SPEC: 1.1.3: Login Ability
  def new
  end

  #SPEC: 1.1.4: Goes to the appropriate screen
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged In!"
    else
      flash.now.alert = "Invalid Credentials"
      render "new"
    end
  end

  #SPEC: 1.1.6: Logout Ability
  #SPEC: 2.3 Log Out
  def destroy
    session[:user_id] = nil
    reset_session
    redirect_to root_path, notice: "Logged Out"
  end
end
