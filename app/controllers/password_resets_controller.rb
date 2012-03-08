class PasswordResetsController < ApplicationController
  #SPEC: 1.1.3.1 Recover Login
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to login_path, :alert => "Instructions for resetting your password have been emailed to you."
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired"
    elsif @user.update_attributes(params[:user])
      redirect_to login_path, :alert => "Password has been reset."
    else
      render :edit
    end
  end

  def show
  end
end
