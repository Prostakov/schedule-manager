class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include ApplicationHelper
  
  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end

end
