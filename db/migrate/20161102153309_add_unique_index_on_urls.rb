class AddUniqueIndexOnUrls < ActiveRecord::Migration
  def change
    remove_index :urls, :code
    add_index :urls, :code, unique: true
  end
end
