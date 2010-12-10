# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :set_facebook_session # this method is in Facebooker plugin
  helper_method :facebook_session     # in case need to get at FB sess in views
  before_filter :set_facebook_user

  def set_facebook_user
    # should really set to a null-object user if no facebook session
    @facebook_user = facebook_session ? facebook_session.user : nil
    logger.info "Facebook user #{@facebook_user}"
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
