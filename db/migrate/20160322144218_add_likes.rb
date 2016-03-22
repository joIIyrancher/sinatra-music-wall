class AddLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :song
      t.references :user
      t.timestamps null: false
    end
  end
end
