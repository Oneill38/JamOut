class Search < ActiveRecord::Base

  def search(zip, range, start, end_date)
    base_url = "http://api.seatgeek.com/2/events?taxonomies.name=concert"
    response = HTTParty.get(base_url, :query => { geoip: zip,
      range: range,
      datetime_utc.gte: start,
      datetime_utc.lte: end_date
        })


  end




end
