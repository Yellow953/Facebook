class CreateFriendRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_requests do |t|
      t.integer :from
      t.integer :to

      t.timestamps
    end
  end
end
