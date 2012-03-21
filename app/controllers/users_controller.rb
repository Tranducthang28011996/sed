class UsersController < ApplicationController
  load_and_authorize_resource

  #SPEC: 2.1 Student Column
  #SPEC: 2.1.1 List all students(users)
  #SPEC: 3.1.2 Sorting options
  def index
    @asc = params[:asc] if params[:asc]
    @sort = params[:sort] if params[:sort]
    if params[:roles_mask] == '1'
      #SPEC: 3.1.1 List all students(users)
      @users = User.students
      if @sort == "name"
        if @asc == '1'
          @users = User.students.order("name ASC")
        else
          @users = User.students.order("name DESC")
        end
      elsif @sort == "email"
        if @asc == '1'
          @users = User.students.order("email ASC")
        else
          @users = User.students.order("email DESC")
        end
      end
      authorize! :list, :students
    elsif params[:roles_mask] == '2'
      @users = User.advisors
      if @sort == "name"
        if @asc == '1'
          @users = User.advisors.order("name ASC")
        else
          @users = User.advisors.order("name DESC")
        end
      elsif @sort == "email"
        if @asc == '1'
          @users = User.advisors.order("email ASC")
        else
          @users = User.advisors.order("email DESC")
        end
      end
      authorize! :list, :advisors
    elsif params[:roles_mask] == '4'
      @users = User.professors
      if @sort == "name"
        if @asc == '1'
          @users = User.professors.order("name ASC")
        else
          @users = User.professors.order("name DESC")
        end
      elsif @sort == "email"
        if @asc == '1'
          @users = User.professors.order("email ASC")
        else
          @users = User.professors.order("email DESC")
        end
      end
      authorize! :list, :professors
    elsif params[:roles_mask] == '8'
      @users = User.gods
      if @sort == "name"
        if @asc == '1'
          @users = User.gods.order("name ASC")
        else
          @users = User.gods.order("name DESC")
        end
      elsif @sort == "email"
        if @asc == '1'
          @users = User.gods.order("email ASC")
        else
          @users = User.gods.order("email DESC")
        end
      end
      authorize! :list, :gods
    else
      if @sort == "name"
        if @asc == '1'
          @users = User.accessible_by(current_ability, :index).order("name ASC")
        else
          @users = User.accessible_by(current_ability, :index).order("name DESC")
        end
      elsif @sort == "email"
        if @asc == '1'
          @users = User.accessible_by(current_ability, :index).order("email ASC")
        else
          @users = User.accessible_by(current_ability, :index).order("email DESC")
        end
      end
      #default case
    end
  end

  def show
  end

  #SPEC: 2.1.3 Add a new User(student)
  def new
  end

  def create
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render "new"
    end
  end

  #SPEC: 2.1.5 Edit a users information
  def edit
    authorize! :edit, @user, :id => current_user.id
  end

  #SPEC: 1.1.3.2. Edit Login
  def edit_password
    @user = User.find_by_id(current_user.id)
    authorize! :edit_password, User, :id => current_user.id
  end

  #SPEC: 1.1.3.2.1 Edit Only Their Own Details
  def edit_my_details
    @user = User.find_by_id(current_user.id)
    authorize! :edit_my_details, User
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

  def update_password
    @user = User.find_by_id(current_user.id)
    authorize! :update_password, User, :id => current_user.id
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

  def update_my_details
    @user = User.find_by_id(current_user.id)
    authorize! :update_my_details, User, :id => current_user.id
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'Your information has been updated.'
    else
      render "edit_my_details"
    end
  end

  #SPEC: 2.1.4 Delete a User(student)
  def destroy
    authorize! :destroy, User, :id => current_user.id
    @user.destroy
    redirect_to users_url
  end
end
