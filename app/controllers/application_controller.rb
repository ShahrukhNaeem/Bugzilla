class ApplicationController < ActionController::Base

	include Pundit
	after_action :verify_authorized, unless: :devise_controller? , except: [:index, :show]

	protect_from_forgery with: :exception

	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_type])
	end
  
end
