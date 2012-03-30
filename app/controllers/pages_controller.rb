class PagesController < ApplicationController
  before_filter :authorize, :only => [:home]
  def home
    @students = User.students.paginate(:page => params[:page], :per_page => 20 ).order("name ASC")
    authorize! :list, :students
  end

  def error
  end
end
