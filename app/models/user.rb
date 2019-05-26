class User < ApplicationRecord
    has_many :articles, dependent: :destroy # this line creates after creating add_user_id_to_article
    #dependent: :destory add this line in user-22
    before_save {self.email = email.downcase} # this line creates after creating add_user_id_to_article
	validates :username, presence: true, 
	uniqueness: { case_sensitive: false }, 
	length: {minimum: 3, maximum: 25}


    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence:true,
	uniqueness: {case_sensitive: false},
	length: {maximum: 100},
	format: { with: VALID_EMAIL_REGEX }

	has_secure_password

end