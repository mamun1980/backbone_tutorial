class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :part1
      t.string :part2

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
