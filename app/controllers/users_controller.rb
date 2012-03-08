class UsersController < ApplicationController
  before_filter :authorize, :except => [:new, :create]
  #SPEC: 2.1 Student Column
  #SPEC: 2.1.1 List all students(users)
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  #SPEC: 2.1.3 Add a new User(student)
  def new
    @user = User.new
  end

  #SPEC: 1.1.3.2. Edit Login
  #SPEC: 2.1.5 Edit a users information
  def edit
    #TODO: make sure they can only edit THEIR login if they're a student
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render "new"
    end
  end

  def edit_password
    @user = User.find_by_id(current_user.id)
  end

  def update_password
    @user = User.find_by_id(current_user.id)
    if @user.authenticate(params[:user][:current_password])
      if @user.update_attributes( :password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation] )
        redirect_to @user, notice: "Password was updated!"
      else
        render "edit_password"
        flash.now[:alert] = "Unable to change password!"
      end
    else
      flash.now[:alert] = "Current User Password was incorrect!"
      render "edit_password"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render "edit"
    end
  end

  #SPEC: 2.1.4 Delete a User(student)
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end
end
