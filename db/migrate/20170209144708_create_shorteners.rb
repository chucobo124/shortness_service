class CreateShorteners < ActiveRecord::Migration
  def change
    create_table :shorteners do |t|
      # we can link this to a user for interesting things
      t.integer :user_id
      t.string :user_type, limit: 20

      # the real url that we will redirect to
      t.text :url, null: false

      # the unique key
      t.string :unique_key, limit: 10, null: false

      # a label to help categorize shortened urls
      t.string :label, :string

      # how many times the link has been clicked
      t.integer :use_count, null: false, default: 0

      # valid until date for expirable urls
      t.datetime :expires_at

      t.timestamps
    end

    # we will lookup the links in the db by key, urls and owners.
    # also make sure the unique keys are actually unique
    add_index :shorteners, :unique_key, unique: true
    add_index :shorteners, :url
    add_index :shorteners, [:user_id, :user_type]
    add_index :shorteners, :label
  end
end
