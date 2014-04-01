class FixTableNameMyevents < ActiveRecord::Migration
  def change
    rename_table :my_events, :tickets
  end
end
