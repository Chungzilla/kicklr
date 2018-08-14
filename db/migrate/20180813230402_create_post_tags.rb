class CreatePostTags < ActiveRecord::Migration[5.2]
  def change
    create_table :post_tags do |t|
      t.belongs_to :post, index: true
      t.belongs_to :tag, index: true
    end
  end
end
