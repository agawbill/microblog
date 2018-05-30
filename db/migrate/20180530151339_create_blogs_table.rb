class CreateBlogsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :content
      t.string :country
      t.string :length
      t.string :url
      t.string :cities
      t.integer :user_id
    # when you have a current user, you have a user_id...
    end
  end
end
