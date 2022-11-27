class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.string :saltedge_id
      t.json :data

      t.timestamps
    end
  end
end
