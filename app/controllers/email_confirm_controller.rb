class EmailConfirmController < ApplicationController
  def new
    @user = User.find_by_auth_token(params[:auth_token])
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_email_confirm if user
    redirect_to root_path, :notice => "Confirmation email has been sent."
  end

  def edit
    @user = User.find_by_email_confirm_token!(params[:id])
  end

  def update
    @user = User.find_by_email_confirm_token!(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to login_path, :notice => "Confirmed!"
    else
      render "edit", :notice => "An unexpected error occured while trying to update."
    end
  end
end
