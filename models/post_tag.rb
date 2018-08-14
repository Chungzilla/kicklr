class Post_Tag <ActiveRecord::Base
    belongs_to :post
    belongs_to :tag
end