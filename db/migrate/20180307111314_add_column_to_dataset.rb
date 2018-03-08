class AddColumnToDataset < ActiveRecord::Migration[5.1]
  def change
    add_column :datasets, :value_user, :string, default: "e"
  end
end
