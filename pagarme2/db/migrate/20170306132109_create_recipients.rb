class CreateRecipients < ActiveRecord::Migration[5.0]
  def change
    create_table :recipients do |t|
      t.string :bank_code, limit:3
      t.string :agencia, limit:4
      t.string :agencia_dv, limit:1
      t.string :conta, limit: 10
      t.string :conta_dv, limit:1
      t.string :legal_name, limit:60
      t.string :document_number, limit:14
      t.text :code
      t.boolean :transfer_enabled

      t.timestamps
    end
  end
end
