class AddDateToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :date, :date
    add_column :blogs, :amount, :float
  end
end
