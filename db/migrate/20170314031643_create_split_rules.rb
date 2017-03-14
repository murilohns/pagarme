class CreateSplitRules < ActiveRecord::Migration[5.0]
  def change
    create_table :split_rules do |t|
      t.string :percentage
      t.references :transaction, foreign_key: true
      t.references :recipient, foreign_key: true

      t.timestamps
    end
  end
end
