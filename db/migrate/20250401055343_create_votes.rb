class CreateVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :votes do |t|
      t.references :account
      t.references :post
      t.boolean :upvote
      t.timestamps
    end
  end
end
