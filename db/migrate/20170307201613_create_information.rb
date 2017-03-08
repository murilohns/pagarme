class CreateInformation < ActiveRecord::Migration[5.0]
  def change
    create_table :information do |t|
      t.string :document_number
      t.string :street
      t.string :neighborhood
      t.string :zipcode
      t.string :street_number
      t.string :complementary
      t.string :ddd
      t.string :phone_number
      t.references :member, foreign_key: true

      t.timestamps
    end
  end
end
