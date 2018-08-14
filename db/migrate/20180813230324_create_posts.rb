class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.timestamp :created_at
      t.timestamp :edited_at
      t.belongs_to :user, index: true
    end
  end
end
