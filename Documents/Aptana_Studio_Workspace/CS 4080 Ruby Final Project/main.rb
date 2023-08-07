# Include the necessary module
require "./manager"

# Define a method for handling the submenu
def submenu(manager, to)
  # Retrieve the list of available coins from the manager
  coin_list = manager.coin_list

  # Display available coins in a formatted manner
  puts "Available Coins"
  puts coin_list.join(", ").center(50, "-")

  # Prompt the user for coin symbol and amount
  print "Coin: "
  symbol = gets.chomp.upcase
  print "Amount: "
  amount = gets.chomp.to_i

  # Check if the entered coin symbol is valid
  if coin_list.include? symbol
    # Calculate the conversion and display the result
    result = manager.calculate(amount, symbol, to)
    puts "-".center(50, "-")
    puts "#{amount} #{symbol} = #{result} #{to}".center(50, "-")
    puts "-".center(50, "-")

    # Ask the user if they want to add a note
    print "Add a note (Y/N): "
    add_note = gets.chomp.upcase
    if add_note == 'Y'
      print "Note: "
      note = gets.chomp
      coin = manager.get_coin(symbol)
      coin.notes << note
    end

    # Ask the user if they want to delete a note
    print "Delete a note (Y/N): "
    delete_note = gets.chomp.upcase
    if delete_note == 'Y'
      coin = manager.get_coin(symbol)
      coin.notes.each_with_index do |note, index|
        puts "#{index + 1}: #{note}"
      end
      print "Select a note to delete (number): "
      note_number = gets.chomp.to_i
      coin.notes.delete_at(note_number - 1) if note_number.positive? && note_number <= coin.notes.length
    end

    # Ask the user if they want to show current notes
    print "Show current notes (Y/N): "
    show_notes = gets.chomp.upcase
    if show_notes == 'Y'
      coin = manager.get_coin(symbol)
      puts "Notes for #{coin.symbol}:"
      coin.notes.each_with_index do |note, index|
        puts "#{index + 1}: #{note}"
      end
    end
  else
    # Inform the user if the entered coin symbol is not available
    puts "#{symbol} is not available.".center(50, "*")
  end
end

# Define the main menu
def menu
  manager = Manager.new
  loop do
    puts "Cryptocurrency Converter ".center(50, "#")
    puts "a) Convert to USD"
    puts "b) Convert to EUR"
    puts "q) Quit"
    print "Action: "
    choice = gets.chomp

    case choice
    when 'a' then submenu(manager, "USD")
    when 'b' then submenu(manager, "EUR")
    end

    # Exit the loop if the user chooses 'q'
    break unless choice != 'q'
  end
end

# Start the main menu
menu()


