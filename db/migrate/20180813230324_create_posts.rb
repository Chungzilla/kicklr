class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.datetime :created_at
      t.datetime :edited_at
      t.belongs_to :user, index: true
    end
  end
end
