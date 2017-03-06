class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  PagarMe.api_key        = 'ak_test_H3FoOSypyOOXc2fcXHpiymRWx8tnKW'
  PagarMe.encryption_key = 'ek_test_isRGBmcfKUcxymEKQhrqEQfeHNFv9n' # If needed

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
