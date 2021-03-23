class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :name
      t.timestamps
      add_reference :blogs, :payment
    end
  end
end
