# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  venue_id   :integer
#  title      :string(255)
#  date       :integer
#  time       :integer
#  url        :text
#  created_at :datetime
#  updated_at :datetime
#

class Event < ActiveRecord::Base
  has_one :venue
  has_many :artists

  validates :title, uniqueness: { scope: :date }

  def self.search(options)

   query = {
      "geoip" => options[:zip_code],
      "range" => options[:radius] + "mi",
      "datetime_utc.gte" => options[:start_date],
      "datetime_utc.lte" => options[:end_date],
   }

   base_url = "http://api.seatgeek.com/2/events?taxonomies.name=concert"

   response = HTTParty.get(base_url, :query => query)

   #Had to call to_json to get the code to work
    better_result = JSON.parse(response.to_json)


    titles = better_result["events"].collect { |hash| hash["title"] }


    times = better_result["events"].collect { |hash| hash["datetime_local"] }


    venues = better_result["events"].collect  {|hash| hash["venue"]["name"] }


    urls = better_result["events"].collect { |hash| hash["performers"][0]["url"] }


   c = titles.count
   t  = Hash.new
   t["title"] = titles
   t["time"] = times
   t["venue"] = venues
   t["url"] = urls

  results = []
   for n in 0..c do
   a = { artist: t["title"][n], time: t["time"][n], venue: t["venue"][n], url: t["url"][n]}
   results << a
  end

  results.map do |entry|
    Event.new(title: entry[:artist], date: entry[:time], url: entry[:url])
   end
  end

end
