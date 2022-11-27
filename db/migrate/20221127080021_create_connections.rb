class CreateConnections < ActiveRecord::Migration[7.0]
  def change
    create_table :connections do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :saltedge_id
      t.json :data

      t.timestamps
    end
  end
end
