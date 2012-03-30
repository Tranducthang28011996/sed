class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You do not have permission to do that!"
    redirect_to error_path
  end

  private

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if (cookies[:auth_token])
  end
  helper_method :current_user

  def authorize
    redirect_to login_path, :notice => "Please login to continue." if current_user.nil?
  end

  helper_method :sort_column, :sort_direction, :sort_scope
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_scope
    flash[:alert] = "sort scope got #{params[:scope]}"
    %w[students advisors professors gods].include?(params[:scope]) ? params[:scope] : "default"
  end
end
