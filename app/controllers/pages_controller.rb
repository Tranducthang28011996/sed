class PagesController < ApplicationController
  before_filter :authorize, :only => [:home]
  def home
  end

  def error
  end
end
