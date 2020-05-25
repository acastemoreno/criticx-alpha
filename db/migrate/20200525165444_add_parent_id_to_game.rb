class AddParentIdToGame < ActiveRecord::Migration[6.0]
  def change
    change_table :games do |t|
      t.references :parent
    end
  end
end
