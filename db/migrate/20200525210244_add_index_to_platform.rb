class AddIndexToPlatform < ActiveRecord::Migration[6.0]
  def change
    add_index :platforms, :category
  end
end
