# Import required libraries
require "uri"
require "net/http"
require "json"
require "./coin"

# The Manager class handles operations related to cryptocurrency conversion and data retrieval.
class Manager
  # Class variable to store cryptocurrency data retrieved from the API.
  @@repo = {}

  # Constructor method to initialize a new Manager instance.
  def initialize
    initialize_repo
  end

  # Initialize the repository with cryptocurrency data obtained through web scraping.
  def initialize_repo
    # Retrieve cryptocurrency data in JSON format from the API.
    response = web_scrap
    # Parse the JSON response to obtain individual coin details.
    json = JSON.parse(response)
    # Iterate through the parsed JSON data to create Coin objects and populate the repository.
    for symbol, values in json
      coin = Coin.new(symbol, values['USD'], values['EUR'])
      @@repo[symbol] = coin
    end
  end

  # Perform web scraping to fetch cryptocurrency data from the API.
  def web_scrap
    url = "https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,XRP,DASH,LTC&tsyms=USD,EUR"
    uri = URI(url)
    # Use the Net::HTTP library to send a GET request and retrieve the response.
    Net::HTTP.get(uri)
  end

  # Retrieve a list of available cryptocurrency symbols.
  def coin_list
    # Retrieve the keys (symbols) of the stored cryptocurrency data.
    @@repo.keys
  end

  # Calculate the conversion of a given amount of cryptocurrency to a specified currency.
  def calculate(amount, symbol, to)
    # Retrieve the Coin object corresponding to the provided symbol.
    coin = @@repo[symbol]
    # Calculate the converted value by multiplying the amount by the currency value.
    amount * coin.send(to.to_sym)
  end

  # Retrieve a specific Coin object based on its symbol.
  def get_coin(symbol)
    # Retrieve the Coin object associated with the provided symbol from the repository.
    @@repo[symbol]
  end
end
