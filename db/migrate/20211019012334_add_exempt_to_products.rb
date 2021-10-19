class AddExemptToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :exempt, :boolean
  end
end
