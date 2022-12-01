class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.references :connection, null: false, foreign_key: true
      t.string :saltedge_id, null: false
      t.json :data

      t.timestamps
    end

    add_index :accounts, :saltedge_id, unique: true
  end
end
