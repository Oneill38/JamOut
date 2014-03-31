class ChangeVenueId < ActiveRecord::Migration
  def change
    rename_column :events, :venues_id, :venue_id
  end
end
