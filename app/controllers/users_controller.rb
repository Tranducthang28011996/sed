class UsersController < ApplicationController
  load_and_authorize_resource

  #SPEC: 2.1 Student Column
  #SPEC: 2.1.1 List all students(users)
  #SPEC: 3.1.2 Sorting options
  def index
    if params[:scope] == "students"
      @users = User.students.page(params[:page]).order(sort_column + " " + sort_direction)
      authorize! :list, :students
    elsif params[:scope] == "advisors"
      @users = User.advisors.page(params[:page]).order(sort_column + " " + sort_direction)
      authorize! :list, :advisors
    elsif params[:scope] == "professors"
      @users = User.professors.page(params[:page]).order(sort_column + " " + sort_direction)
      authorize! :list, :professors
    elsif params[:scope] == "gods"
      @users = User.gods.page(params[:page]).order(sort_column + " " + sort_direction)
      authorize! :list, :gods
    else
      @users = User.accessible_by(current_ability, :index).order(sort_column + " " + sort_direction).page(params[:page])
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  def show
    @student = User.students.where(:id => params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.js { render :layout => false }
    end
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

  def search
    @students = User.search(params[:search], params[:page], 30).order(sort_column + " " + sort_direction)
    authorize! :search, User
  end
end
