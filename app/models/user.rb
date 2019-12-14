class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: %i[facebook google_oauth2]
         
  has_one :address
  accepts_nested_attributes_for :address

  has_many :sns_credentials, dependent: :destroy

      def self.from_omniauth(auth)
      user = User.where(email: auth.info.email).first
      sns_credential_record = SnsCredential.where(users: auth.users,provider: auth.provider, uid: auth.uid,token: auth.token)
      if user.present?
        unless sns_credential_record.present?
          SnsCredential.create(
            users: auth.users,
            token: auth.token,
            user_id: user.id,
            provider: auth.provider,
            uid: auth.uid
          )
        end
      elsif
        user = User.new(
          id: User.all.last.id + 1,
          email: auth.info.email,
          password: Devise.friendly_token[0, 20],
          # nickname: auth.info.name,
          # last_name: auth.info.last_name,
          # first_name: auth.info.first_name,
        )
        SnsCredential.new(
          users: auth.users,
          token: auth.token,
          provider: auth.provider,
          uid: auth.uid,
          # user_id: user.id
          nickname: auth.info.name,
          last_name: auth.info.last_name,
          first_name: auth.info.first_name,
        )
        SnsCredential.new(
          provider: auth.provider,
          uid: auth.uid,
          user_id: user.id
        )
      end 
    user
    end
end
