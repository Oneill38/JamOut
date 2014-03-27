class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :venues
      t.string :title
      t.integer :date
      t.integer :time
      t.text :url
      t.timestamps
    end
  end
end
