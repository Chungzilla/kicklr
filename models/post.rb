class Post < ActiveRecord::Base
    belongs_to :user
    has_many :tags, :through => :post_tags
    validates :email, uniqueness: {case_sensitive: false}
end