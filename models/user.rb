class User < ActiveRecord::Base
    has_many :posts
    validates_presence_of :first_name
    validates_presence_of :last_name
    validates_presence_of :username
    validates_uniqueness_of :username, {case_sensitive: false, message: "Account already exists with this username. Welcome back, please login!"}
    validates_uniqueness_of :email, {case_sensitive: false, message: "Account already exists with this email. Welcome back, please login!"}
    validates_presence_of :password
    validates_presence_of :birthday
end