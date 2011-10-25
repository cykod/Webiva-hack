class Categories < ActiveRecord::Migration
  def self.up
    create_table :hack_categories do |t|
      t.string :name
      t.integer :weight
    end
    add_column :hack_category_id, :integer
  end

  def self.down
    drop_table :hack_categories
    remove_column :hack_category_id
  end
end
