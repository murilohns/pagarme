class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :neighborhood
      t.string :zipcode
      t.string :street_number
      t.string :complementary
      t.references :member, foreign_key: true

      t.timestamps
    end
  end
end
