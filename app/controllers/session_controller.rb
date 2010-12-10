class SessionController < ApplicationController

  def create
    # this method receives a POST from Facebook when a user succesfully
    # authenticates via FB Connect.  Here, we just show an
    # acknowledgment message and go back to the movies page.
    flash[:notice] = "Welcome, Facebook user!"
    redirect_to movies_path
  end

  def destroy
    # disconnect from FacebookConnect
    flash[:notice] = "Goodbye, Facebook user!"
    clear_fb_cookies!
    clear_facebook_session_information
    redirect_to movies_path
  end
end 
