class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :card_number, limit: 19 
      t.string :card_holder_name, limit: 60 
      t.string :card_expiration_month, limit: 2
      t.string :card_expiration_year, limit: 4
      t.string :card_cvv, limit: 3
      t.string :card_hash

      t.timestamps
    end
  end
end
