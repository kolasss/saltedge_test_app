class CreateProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :providers do |t|
      t.string :code, null: false
      t.json :data

      t.timestamps
    end

    add_index :providers, :code, unique: true
  end
end
