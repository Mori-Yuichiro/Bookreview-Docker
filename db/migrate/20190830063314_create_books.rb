class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :review
      t.string :image_url
      t.references :user, foreign_key: true
      t.references :kind, foreign_key: true

      t.timestamps
    end
  end
end
