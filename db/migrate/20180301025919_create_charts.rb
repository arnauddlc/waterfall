class CreateCharts < ActiveRecord::Migration[5.1]
  def change
    create_table :charts do |t|
      t.string :title, default: "Chart Title"
      t.string :subtitle, default: "chart subtitle"
      t.text :notes
      t.integer :font_size, default: 12
      t.string :color, default: "$green: #3EC28F"
      t.string :chart_image, default: "http://res.cloudinary.com/arnauddlc/image/upload/v1519980141/waterfall.png"
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
