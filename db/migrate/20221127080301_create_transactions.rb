class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.string :saltedge_id, null: false
      t.json :data

      t.timestamps
    end

    add_index :transactions, :saltedge_id, unique: true
  end
end
