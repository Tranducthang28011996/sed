class UsersController < ApplicationController
#before_filter :authorize
  load_and_authorize_resource
  #SPEC: 2.1 Student Column
  #SPEC: 2.1.1 List all students(users)
  def index
    #SPEC: 3.1.1 List all students(users)
    authorize! :list, :students
    if params[:roles_mask] == '1'
      @users = User.students
    elsif params[:roles_mask] == '2'
      authorize! :list, :advisors
      @users = User.advisors
    elsif params[:roles_mask] == '4'
      authorize! :list, :professors
      @users = User.professors
    elsif params[:roles_mask] == '8'
      authorize! :list, :gods
      @users = User.gods
    else
      authorize! :manage, User
    end
  end

  def show
    authorize! :read, User
  end

  #SPEC: 2.1.3 Add a new User(student)
  def new
    @user = User.new
    authorize! :manage, User
  end

  #SPEC: 2.1.5 Edit a users information
  def edit
    #TODO: make sure they can only edit THEIR login if they're a student
  end

  def create
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render "new"
    end
  end

  #SPEC: 1.1.3.2. Edit Login
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

  #SPEC: 1.1.3.2.1 Edit Only Their Own Details
  def edit_my_details
    @user = User.find_by_id(current_user.id)
  end

  def update_my_details
    @user = User.find_by_id(current_user.id)
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'Your information has been updated.'
    else
      render "edit_my_details"
    end
  end

  #SPEC: 3.1.3 Update Student Status
  def update
    authorize! :assign_roles, @user if params[:user][:assign_roles]
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render "edit"
    end
  end

  #SPEC: 2.1.4 Delete a User(student)
  def destroy
    @user.destroy
    redirect_to users_url
  end
end
