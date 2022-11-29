class CreateFriendRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_requests do |t|
      t.integer :from
      t.integer :to
      #indexes record assosiation on rails documentation
      t.timestamps
    end
  end
end
