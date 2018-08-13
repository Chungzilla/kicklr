class Post < AvctiveRecord::Base
    belongs_to :user
    has_many :tags, :through => :posts_tags
end