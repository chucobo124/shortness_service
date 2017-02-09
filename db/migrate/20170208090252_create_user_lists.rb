class CreateUserLists < ActiveRecord::Migration[5.0]
  def change
    create_table :user_lists do |t|
      t.string :session_id

      t.timestamps
    end
  end
end
