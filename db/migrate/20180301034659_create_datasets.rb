class CreateDatasets < ActiveRecord::Migration[5.1]
  def change
    create_table :datasets do |t|
      t.string :label
      t.integer :value, default: 0
      t.references :chart, foreign_key: true

      t.timestamps
    end
  end
end
