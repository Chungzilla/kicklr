class User < ActiveRecord::Base
    has_many :posts
    validates_presence_of :first_name
    validates_presence_of :last_name
    validates_presence_of :username
    validates :username, uniqueness: true
    validates_presence_of :email
    validates :email, uniqueness: true
    validates_presence_of :password
    validates_presence_of :birthday
end