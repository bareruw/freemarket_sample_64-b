class SignupController < ApplicationController
  def index
  end

  def registration
    @user = User.new
  end

  def sms_confirmation
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:family_name_kanji] = user_params[:family_name_kanji]
    session[:first_name_kanji] = user_params[:first_name_kanji]
    session[:family_name_kana] = user_params[:family_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birthdata_year] = user_params[:birthdata_year]
    session[:birthdata_month] = user_params[:birthdata_month]
    session[:birthdata_day] = user_params[:birthdata_day]
    @user = User.new
    
  end

  def input_address
    session[:phone_number] = user_params[:phone_number]
    @user = User.new
    @user.build_address
  end

  def payment
    session[:address_attributes] = user_params[:address_attributes]
    @user = User.new
    @user.build_address
  end

  def signup_complete
    @user = User.new
  end

  def login
  end
  private
  def user_params
    params.require(:user).permit(
      :nickname,
      :ntroduce,
      :family_name_kanji,
      :first_name_kanji,
      :family_name_kana,
      :first_name_kana,
      :birthdata_year,
      :birthdata_month,
      :birthdata_day,
      :phone_number,
      :email,
      :password,
      :reset_password_token,
      :reset_password_sent_at,
      :remember_created_at,
      address_attributes: [:id, :family_name, :first_name, :family_name_katakana, :first_name_katakana, :postcode, :prefecture, :city, :block, :building, :telephone_number]
    )
  end
end
