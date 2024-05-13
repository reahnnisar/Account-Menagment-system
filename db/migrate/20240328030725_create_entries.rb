class CreateEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :entries do |t|
      t.date :entry_date
      t.integer :amount
      t.text :description

      t.timestamps
    end
  end
end
