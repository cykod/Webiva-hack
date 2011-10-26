class Categories < ActiveRecord::Migration
  def self.up
    create_table :hack_categories do |t|
      t.string :name
      t.integer :weight
    end
    create_table :hack_category_votes do |t|
      t.integer :hack_category_id
      t.integer :hack_vote_id
    end
  end

  def self.down
    drop_table :hack_categories
    drop_table :hack_category_votes
  end
end
