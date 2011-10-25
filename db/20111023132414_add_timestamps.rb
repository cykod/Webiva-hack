class AddTimestamps < ActiveRecord::Migration
  def self.up
    add_column :hack_ideas, :created_at, :datetime
    add_column :hack_ideas, :updated_at, :datetime

    add_column :hack_ideas, :email, :string
    add_column :hack_ideas, :weight, :integer, :default => 0

    add_column :hack_ideas, :category, :string


    add_column :hack_votes, :created_at, :datetime
    add_column :hack_votes, :updated_at, :datetime
  end

  def self.down
    remove_column :hack_ideas, :created_at
    remove_column :hack_ideas, :updated_at

    remove_column :hack_ideas,:email
    remove_column :hack_ideas,:weight
    remove_column :hack_ideas,:category


    remove_column :hack_votes, :created_at
    remove_column :hack_votes, :updated_at
  end
end
