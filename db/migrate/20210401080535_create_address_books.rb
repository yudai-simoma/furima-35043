class CreateAddressBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :address_books do |t|

      t.timestamps
    end
  end
end
