# Define the Coin class
class Coin
  # This class represents a cryptocurrency coin with its symbol, values in USD and EUR, and associated notes.

  # Create attribute accessors for the symbol, USD value, EUR value, and notes of the coin.
  attr_accessor :symbol, :USD, :EUR, :notes
  
  # Constructor method to initialize a new Coin instance.
  def initialize(symbol, usd, eur)
    # Initialize instance variables with the provided values.
    @symbol = symbol   # Symbol of the cryptocurrency (e.g., BTC)
    @USD = usd         # Value of the cryptocurrency in USD
    @EUR = eur         # Value of the cryptocurrency in EUR

    @notes = []        # Array to store notes associated with the coin
  end
end
