# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?  
      sign_in_and_redirect @user, event: :authentication 
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else 
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to registration_signup_index_path
    end
  end

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication 
      set_flash_message(:notice, :success, kind: 'google') if is_navigational_format?
    else
      session["omniauth.google_data"] = request.env["omniauth.auth"][:info]
      redirect_to registration_signup_index_path
    end
  end
end

