class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :url
      t.string :code
    end

    add_index :urls, :code
  end
end
