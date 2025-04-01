class AddCommunitiesSummary < ActiveRecord::Migration[8.0]
  def change
    add_column :communities, :summary, :string
  end
end
