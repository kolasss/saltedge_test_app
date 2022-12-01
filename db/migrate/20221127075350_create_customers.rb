class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :saltedge_id, null: false
      t.json :data

      t.timestamps
    end

    add_index :customers, :saltedge_id, unique: true
  end
end
