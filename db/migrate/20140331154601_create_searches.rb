class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :title
      t.string :time
      t.string :venue
      t.string :url
      t.timestamps
    end
  end
end
