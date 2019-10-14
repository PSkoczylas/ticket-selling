class CreateTicketPurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :ticket_purchases do |t|
      t.string :email
      t.string :token

      t.references :ticket, null: false, foreign_key: true
    end
  end
end
