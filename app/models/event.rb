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
  belongs_to(:venue)
  has_many :artists
  has_many :tickets

  validates :title, uniqueness: { scope: :date }
  validates :title, presence: true
  validates :date, presence: true
  validates :url, presence: true

  def self.search(options)

   query = {
      "geoip" => options[:zip_code],
      "range" => options[:radius] + "mi",
      "datetime_utc.gte" => options[:start_date],
      "datetime_utc.lte" => options[:end_date],
   }

   base_url = "http://api.seatgeek.com/2/events?taxonomies.name=concert&per_page=50"

   response = HTTParty.get(base_url, :query => query)

   #Had to call to_json to get the code to work
    better_result = JSON.parse(response.to_json)

    #This is for the events
    titles = better_result["events"].collect { |hash| hash["title"] }
    dates = better_result["events"].collect { |hash| hash["datetime_local"].to_s }
    venues = better_result["events"].collect  {|hash| hash["venue"]["name"] }
    urls = better_result["events"].collect { |hash| hash["performers"][0]["url"] }

    #This is for the venue
    name = better_result["events"].collect { |hash| hash["venue"]["name"]}
    street = better_result["events"].collect { |hash| hash["venue"]["address"]}
    city = better_result["events"].collect { |hash| hash["venue"]["city"]}
    state = better_result["events"].collect { |hash| hash["venue"]["state"]}
    zip = better_result["events"].collect { |hash| hash["venue"]["postal_code"]}

   co = name.count
   tt  = Hash.new
   tt["name"] = name
   tt["street"] = street
   tt["city"] = city
   tt["state"] = state
   tt["zip"] = zip


  resul = []
   for n in 0..co do
     v = { name: tt["name"][n], street: tt["street"][n], city: tt["city"][n], state: tt["state"][n], zip: tt["zip"][n]}
     resul << v
   end


   resul.map do |entry|
    Venue.create(name: entry[:name], street: entry[:street], city: entry[:city], state: entry[:state], zip: entry[:zip])
   end
    # OPTIMIZE comment what all this code does

   c = titles.count
   t  = Hash.new
   t["title"] = titles
   t["date"] = dates
   t["venue"] = venues
   t["url"] = urls

  results = []
   for n in 0..c
     a = { artist: t["title"][n], date: t["date"][n], venue: t["venue"][n], url: t["url"][n]}
     results << a
   end
   binding.pry

  #This pop, pops off last result which is blank
  results.pop
  results.map do |entry|
     v = Venue.find_by(name: entry[:venue])
     Event.create(venue_id: v.id, title: entry[:artist], date: entry[:date].to_s, url: entry[:url])
   end
  end

end
