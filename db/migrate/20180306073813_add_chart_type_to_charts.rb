class AddChartTypeToCharts < ActiveRecord::Migration[5.1]
  def change
    add_column :charts, :chart_type, :string
  end
end
