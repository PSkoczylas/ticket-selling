class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.text :info
      t.decimal :price, :precision => 8, :scale => 2 
      t.string :currency, default: "EUR"
      t.integer :available_quantity
      
      t.references :event, null: false, foreign_key: true
    end
  end
end
