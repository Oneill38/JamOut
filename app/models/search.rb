class Search < ActiveRecord::Base

  def title
    c = response["events"].count
    e_title = response["events"][]
  end

  def @search
   session[:zip] = params[:zip_code]
    session[:radius] = params[:radius] + "mi"
    session[:start] = params[:start_date]
    session[:end] = params[:end_date]
    @zip = session[:zip]
    @radius = session[:radius]
    @start = session[:start]
    @end = session[:end]

   base_url = "http://api.seatgeek.com/2/events?taxonomies.name=concert"

   response = HTTParty.get(base_url, :query => {
      "geoip" => @zip,
      "range" => @radius,
      "datetime_utc.gte" => @start,
      "datetime_utc.lte" => @end
   })

    better_result = JSON.parse(response.to_json)

    session[:title] = better_result["events"].collect do |hash|
      hash["title"]
      end

    session[:time] = better_result["events"].collect do |hash|
      hash["datetime_local"]
    end

    session[:venue] = better_result["events"].collect do |hash|
      hash["venue"]["name"]
    end

    session[:url] = better_result["events"].collect do |hash|
      hash["performers"][0]["url"]
    end


  end
