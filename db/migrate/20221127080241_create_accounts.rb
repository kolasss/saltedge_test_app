class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.references :connection, null: false, foreign_key: true
      t.string :saltedge_id
      t.json :data

      t.timestamps
    end
  end
end
