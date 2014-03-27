class JoinEventsUsers < ActiveRecord::Migration
  def change
    create_table :my_events do |t|
      t.references :users
      t.references :events
    end
  end
end
