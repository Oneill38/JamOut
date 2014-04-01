class FixMyeventsTable < ActiveRecord::Migration
  def change
    rename_column :my_events, :users_id, :user_id
    rename_column :my_events, :events_id, :event_id

  end
end
