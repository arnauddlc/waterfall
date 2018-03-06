class RemoveTypeFromCharts < ActiveRecord::Migration[5.1]
  def change
    remove_column :charts, :type
  end
end
