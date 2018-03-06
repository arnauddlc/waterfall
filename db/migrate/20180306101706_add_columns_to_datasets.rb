class AddColumnsToDatasets < ActiveRecord::Migration[5.1]
  def change
    add_column :datasets, :serietype, :string, default: "baseline"
    add_column :datasets, :offset, :integer, default: 0
  end
end
