class AddAttributesToListings < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :title, :string
    add_column :listings, :description, :text
    add_column :listings, :address, :string
  end
end
