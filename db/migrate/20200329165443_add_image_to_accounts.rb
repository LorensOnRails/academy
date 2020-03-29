class AddImageToAccounts < ActiveRecord::Migration[6.0]
  def change
  	add_column :accounts, :image_data, :text
  end
end
