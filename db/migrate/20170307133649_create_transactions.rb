class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.string :pay_method
      t.references :member, foreign_key: true
      t.text :boleto_url
      t.text :boleto_barcode
      t.text :card_hash
      t.boolean :division
      t.string :status

      t.timestamps
    end
  end
end
