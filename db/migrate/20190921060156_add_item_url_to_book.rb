class AddItemUrlToBook < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :itemUrl, :string
  end
end
