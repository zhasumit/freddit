class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.references :account
      t.references :post
      t.text :message

      t.timestamps
    end
  end
end
