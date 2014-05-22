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
  has_many :users, through: :tickets
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

    results = []
    ###iterating through results, creating the venues
    better_result["events"].each do |v|
      venue = Venue.new
      venue.name = v["venue"]["name"]
      venue.street = v["venue"]["address"]
      venue.city = v["venue"]["city"]
      venue.state = v["venue"]["state"]
      venue.zip = v["venue"]["postal_code"]
      venue.save
    end

    #iterating through results, creating the events, and finding the venue
    better_result["events"].each do |e|
      event = Event.new
      the_venue = Venue.find_by(name: e["venue"]["name"] )
      event_time = event.fix_time(e["datetime_local"].to_s)
      event_date = event.fix_date(e["datetime_local"].to_s)
      event.venue_id = the_venue.id
      event.title = e["title"]
      event.time = event_time
      event.date = event_date
      event.url = e["url"]
      event.picture = e["performers"][0]["image"]
      event.min = e["stats"]["lowest_price"]
      event.max = e["stats"]["highest_price"]
      event.save
      results << event
    end

    return results
  end

  def fix_time(the_time)
    time = the_time.split("T")[1]
    time.slice!(5..7)
    hour = time[0..1]
    if hour.to_i >= 13
      hour = hour.to_i - 12
      time.slice!(0..1)
      time = (hour).to_s + time + " PM "
    end
    return time
  end

  def fix_date(the_date)
    date = the_date.split("T")[0]
    month = {"01" => "January", "02" => "February", "03" => "March", "04" => "April", "05" => "May", "06" => "June", "07" => "July", "08" => "August", "09" => "September", "10" => "October", "11" => "November", "12" => "December"}
    my_month = date[5..6]
    event_month = month[my_month]
    day = date[8..9]
    year = date[0..3]
    total_event_date = event_month + " " + day + ", " + year

    return total_event_date

  end

end
