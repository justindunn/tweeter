class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.text :message
      t.string :twitter_id
      t.integer :tweet_id

      t.timestamps
    end
  end
end
