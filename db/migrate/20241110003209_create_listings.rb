class CreateListings < ActiveRecord::Migration[8.0]
  def change
    create_table :listings do |t|
      t.string :name
      t.decimal :price
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
