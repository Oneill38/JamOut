class AddImages < ActiveRecord::Migration
  def change
    add_column :events, :min, :string
    add_column :events, :max, :string
    add_column :events, :picture, :text

  end
end
