require "sinatra"
require "sinatra/reloader"
require "http"
require "json"


get("/") do
 


# Hidden variables
key = ENV["EXCHANGE_RATE_KEY"]
exchangerate_url = "https://api.exchangerate.host/list?access_key=" + key

# Place a GET request to the URL
raw_exchange = HTTP.get(exchangerate_url)
raw_data_string = raw_exchange.to_s


parsed_exchange = JSON.parse(raw_data_string)
@symbols = parsed_exchange.fetch("currencies").keys
erb(:homepage)
end


get("/:from_currency") do
  key = ENV["EXCHANGE_RATE_KEY"]
  @original_currency = params.fetch("from_currency")
  
  exchangerate_url = "https://api.exchangerate.host/list?access_key=" + key + "&from=" + @original_currency.to_s
  raw_exchange = HTTP.get(exchangerate_url)
  raw_data_string = raw_exchange.to_s


  parsed_exchange = JSON.parse(raw_data_string)
  @symbols = parsed_exchange.fetch("currencies").keys
  # some more code to parse the URL and render a view template
  erb(:flexible)
end

get("/:from_currency") do
  key = ENV["EXCHANGE_RATE_KEY"]
  @original_currency = params.fetch("from_currency")
  
  exchangerate_url = "https://api.exchangerate.host/list?access_key=" + key + "&from=" + @original_currency.to_s
  raw_exchange = HTTP.get(exchangerate_url)
  raw_data_string = raw_exchange.to_s


  parsed_exchange = JSON.parse(raw_data_string)
  @symbols = parsed_exchange.fetch("currencies").keys
  # some more code to parse the URL and render a view template
  erb(:flexible)
end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")
  key = ENV["EXCHANGE_RATE_KEY"]

  exchangerate_url = "https://api.exchangerate.host/convert?access_key=#{key}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
  raw_exchange = HTTP.get(exchangerate_url)
  raw_data_string = raw_exchange.to_s


  parsed_exchange = JSON.parse(raw_data_string)
  @result = parsed_exchange.fetch("result")
  # some more code to parse the URL and render a view template
  erb(:result)
end
