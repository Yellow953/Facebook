class CreateFriends < ActiveRecord::Migration[7.0]
  def change
    create_table :friends do |t|
      t.belongs_to :user
      t.integer :friend_with

      t.timestamps
    end
  end
end
