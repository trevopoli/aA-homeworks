class ChangeAddIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :questions, :poll_id
    add_index :polls, :user_id
  end
end
