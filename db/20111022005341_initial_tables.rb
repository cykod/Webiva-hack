class InitialTables < ActiveRecord::Migration
  def self.up
    create_table :hack_ideas do |t|
      t.string :title
      t.text :description
      t.integer :image_id
      t.integer :audio_id
      t.integer :end_user_id
      t.string :permalink


      t.integer :votes, :default => 0
      t.integer :score, :default => 0
    end


    create_table :hack_votes do |t|
      t.integer :hack_idea_id
      t.string :source
      t.integer :value
      t.integer :end_user_id
      t.boolean :track, :default => false
      t.string  :domain_log_session_id
    end

    add_index :hack_ideas, :permalink

  end

  def self.down
    drop_table :hack_ideas
    drop_table :hack_votes
  end
end
