class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  private
    
    def not_authorized
      redirect_to root_path, alert: "You aren't allowed to do that."
    end

end
