class UsersController < ApplicationController
#before_filter :authorize
  #load_and_authorize_resource
  authorize_resource
  #SPEC: 2.1 Student Column
  #SPEC: 2.1.1 List all students(users)
  def index
    #SPEC: 3.1.1 List all students(users)
    if params[:roles_mask] == '1'
      if params[:sort] == "name"
        if params[:asc] == '1'
          @users = User.students.order("name ASC")
          authorize! :list, :students
        elsif params[:asc] == '0'
          @users = User.students.order("name DESC")
          authorize! :list, :students
        else
          @users = User.students
          authorize! :list, :students
        end
      else
        @users = User.students
        authorize! :list, :students
      end #end sort by name
    elsif params[:roles_mask] == '2'
      @users = User.advisors
      authorize! :list, :advisors
    elsif params[:roles_mask] == '4'
      @users = User.professors
      authorize! :list, :professors
    elsif params[:roles_mask] == '8'
      @users = User.gods
      authorize! :list, :gods
    else
      @users = User.where("roles_mask < 4")
      authorize! :manage, User
    end
  end

  def show
    @user = User.find(params[:id])
    authorize! :manage, User
  end

  #SPEC: 2.1.3 Add a new User(student)
  def new
    @user = User.new
    authorize! :manage, User
  end

  #SPEC: 2.1.5 Edit a users information
  def edit
    #TODO: make sure they can only edit THEIR login if they're a student
    @user = User.find(params[:id])
    authorize! :manage, User
  end

  def create
    @user = User.new(params[:user])
    authorize! :create, User
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render "new"
    end
  end

  #SPEC: 1.1.3.2. Edit Login
  def edit_password
    @user = User.find_by_id(current_user.id)
    authorize! :edit_password, User
  end

  def update_password
    @user = User.find_by_id(current_user.id)
    authorize! :update_password, User
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
    authorize! :edit_my_details, User
  end

  def update_my_details
    @user = User.find_by_id(current_user.id)
    authorize! :update_my_details, User
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'Your information has been updated.'
    else
      render "edit_my_details"
    end
  end

  #SPEC: 3.1.3 Update Student Status
  def update
    authorize! :assign_roles, @user if params[:user][:assign_roles]
    @user = User.find(params[:id])
    authorize! :manage, User
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render "edit"
    end
  end

  #SPEC: 2.1.4 Delete a User(student)
  def destroy
    @user = User.find(params[:id])
    authorize! :destroy, User
    @user.destroy
    redirect_to users_url
  end
end
