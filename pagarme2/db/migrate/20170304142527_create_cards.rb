class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.references :member, foreign_key: true
      t.string :card_hash

      t.timestamps
    end
  end
end
