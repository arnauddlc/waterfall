class CreateCharts < ActiveRecord::Migration[5.1]
  def change
    create_table :charts do |t|
      t.string :title
      t.string :subtitle
      t.text :notes
      t.integer :font_size
      t.string :color
      t.string :chart_image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
