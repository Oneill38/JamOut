class CreateArtistsEvents < ActiveRecord::Migration
  def change
    create_table :artists_events, id: false do |t|
      t.references :artists
      t.references :events
    end
  end
end
