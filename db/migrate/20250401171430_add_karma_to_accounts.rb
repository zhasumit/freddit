class AddKarmaToAccounts < ActiveRecord::Migration[8.0]
  def change
    add_column :accounts, :karma, :integer, default: 0
  end
end
