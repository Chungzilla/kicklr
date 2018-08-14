class Post < ActiveRecord::Base
    belongs_to :user
    has_many :tags, :through => :post_tags
    validates_presence_of :title, message: "Cannot be blank"
    validates_presence_of :content, message: "Cannot be blank"
end