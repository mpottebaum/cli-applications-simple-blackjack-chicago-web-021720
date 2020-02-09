require 'pry'

deck_of_cards = [{:card => "2", :suit => "Hearts", :value => 1, :points => 1}, {:card => "3", :suit => "Hearts", :value => 2, :points => 1}, {:card => "4", :suit => "Hearts", :value => 3, :points => 1}, {:card => "5", :suit => "Hearts", :value => 4, :points => 1}, {:card => "6", :suit => "Hearts", :value => 5, :points => 1}, {:card => "7", :suit => "Hearts", :value => 6, :points => 1}, {:card => "8", :suit => "Hearts", :value => 7, :points => 1}, {:card => "9", :suit => "Hearts", :value => 8, :points => 1}, {:card => "10", :suit => "Hearts", :value => 9, :points => 1}, {:card => "Jack", :suit => "Hearts", :value => 10, :points => 1}, {:card => "Queen", :suit => "Hearts", :value => 11, :points => 1}, {:card => "King", :suit => "Hearts", :value => 12, :points => 1}, {:card => "Ace", :suit => "Hearts", :value => 13, :points => 1}, {:card => "2", :suit => "Clubs", :value => 1, :points => 0}, {:card => "3", :suit => "Clubs", :value => 2, :points => 0}, {:card => "4", :suit => "Clubs", :value => 3, :points => 0}, {:card => "5", :suit => "Clubs", :value => 4, :points => 0}, {:card => "6", :suit => "Clubs", :value => 5, :points => 0}, {:card => "7", :suit => "Clubs", :value => 6, :points => 0}, {:card => "8", :suit => "Clubs", :value => 7, :points => 0}, {:card => "9", :suit => "Clubs", :value => 8, :points => 0}, {:card => "10", :suit => "Clubs", :value => 9, :points => 0}, {:card => "Jack", :suit => "Clubs", :value => 10, :points => 0}, {:card => "Queen", :suit => "Clubs", :value => 11, :points => 0}, {:card => "King", :suit => "Clubs", :value => 12, :points => 0}, {:card => "Ace", :suit => "Clubs", :value => 13, :points => 0}, {:card => "2", :suit => "Diamonds", :value => 1, :points => 0}, {:card => "3", :suit => "Diamonds", :value => 2, :points => 0}, {:card => "4", :suit => "Diamonds", :value => 3, :points => 0}, {:card => "5", :suit => "Diamonds", :value => 4, :points => 0}, {:card => "6", :suit => "Diamonds", :value => 5, :points => 0}, {:card => "7", :suit => "Diamonds", :value => 6, :points => 0}, {:card => "8", :suit => "Diamonds", :value => 7, :points => 0}, {:card => "9", :suit => "Diamonds", :value => 8, :points => 0}, {:card => "10", :suit => "Diamonds", :value => 9, :points => 0}, {:card => "Jack", :suit => "Diamonds", :value => 10, :points => 0}, {:card => "Queen", :suit => "Diamonds", :value => 11, :points => 0}, {:card => "King", :suit => "Diamonds", :value => 12, :points => 0}, {:card => "Ace", :suit => "Diamonds", :value => 13, :points => 0}, {:card => "2", :suit => "Spades", :value => 1, :points => 0}, {:card => "3", :suit => "Spades", :value => 2, :points => 0}, {:card => "4", :suit => "Spades", :value => 3, :points => 0}, {:card => "5", :suit => "Spades", :value => 4, :points => 0}, {:card => "6", :suit => "Spades", :value => 5, :points => 0}, {:card => "7", :suit => "Spades", :value => 6, :points => 0}, {:card => "8", :suit => "Spades", :value => 7, :points => 0}, {:card => "9", :suit => "Spades", :value => 8, :points => 0}, {:card => "10", :suit => "Spades", :value => 9, :points => 0}, {:card => "Jack", :suit => "Spades", :value => 10, :points => 0}, {:card => "Queen", :suit => "Spades", :value => 11, :points => 13}, {:card => "King", :suit => "Spades", :value => 12, :points => 0}, {:card => "Ace", :suit => "Spades", :value => 13, :points => 0}]

user_player = {:name => "User", :hand => [], :points => 0}
charlie_player = {:name => "Charlie", :hand => [], :points => 0}
susan_player = {:name => "Susan", :hand => [], :points => 0}
kendra_player = {:name => "Kendra", :hand => [], :points => 0}

def welcome
  puts "Ready to play some Hearts?"
  puts "Press ENTER to deal"
  gets
end

def deal_single_card(deck_array)
  card_index = rand(deck_array.length)
  deck_array.slice!(card_index)
end

def deal(dealer, left, across, right, deck_array)
  deck_length = deck_array.length
  while deck_length > 0 do
    left[:hand] << deal_single_card(deck_array)
    across[:hand] << deal_single_card(deck_array)
    right[:hand] << deal_single_card(deck_array)
    dealer[:hand] << deal_single_card(deck_array)
    deck_length = deck_array.length
  end
end

def dealer_order_array(user_player, charlie_player, susan_player, kendra_player)
  [user_player, charlie_player, susan_player, kendra_player]
end

def change_dealer(array_of_players)
  last_dealer = array_of_players.shift
  array_of_players.push(last_dealer)
end

def display_user_hand(user_player)
  hand = sort_cards(user_player[:hand])
  display = "Your hand: "
  i = 0
  while i < (hand.length - 1) do
    if (display.length >= 71 && display.length <= 79) || (display.length >= 149 && display.length <= 158)
      display = display + "\n#{i + 1}. #{hand[i][:card]} of #{hand[i][:suit]}, "
    else
      display = display + "#{i + 1}. #{hand[i][:card]} of #{hand[i][:suit]}, "
    end
    i += 1
  end
  display = display + "#{i + 1}. #{hand[i][:card]} of #{hand[i][:suit]}"
  puts "\n"
  puts display
  hand
end

def sort_by_value(cards)
  low_to_high = cards.sort {|a, b| a[:value] <=> b[:value]}
  high_to_low = low_to_high.reverse
  high_to_low
end

def sort_cards(user_hand)
  hearts = user_hand.select {|card| card[:suit] == "Hearts"}
  clubs = user_hand.select {|card| card[:suit] == "Clubs"}
  diamonds = user_hand.select {|card| card[:suit] == "Diamonds"}
  spades = user_hand.select {|card| card[:suit] == "Spades"}
  suits = [hearts, clubs, diamonds, spades]
  sorted_suits = []
  suits_length = suits.length
  while suits_length > 0 do
    most_suit = suits.max {|a, b| a.length <=> b.length}
    most_suit_index = suits.index(most_suit)
    sorted_suits << most_suit
    suits.slice!(most_suit_index)
    suits_length = suits.length
  end
  sorted_hand = sorted_suits.map {|suit_array| sort_by_value(suit_array)}
  flat_sorted = sorted_hand.flatten
  flat_sorted
end

def display_user_hand_no_numbers(user_player)
  hand = sort_cards(user_player[:hand])
  display = "Your hand: "
  i = 0
  while i < (hand.length - 1) do
    if (display.length >= 71 && display.length <= 79) || (display.length >= 149 && display.length <= 158)
      display = display + "\n#{hand[i][:card]} of #{hand[i][:suit]}, "
    else
      display = display + "#{hand[i][:card]} of #{hand[i][:suit]}, "
    end
    i += 1
  end
  display = display + "#{hand[i][:card]} of #{hand[i][:suit]}"
  puts "\n"
  puts display
  hand
end

def find_two_of_clubs(player)
  # looks for two of clubs in player hand and returns boolean value 
  player[:hand].any? {|card| card[:card] == "2" and card[:suit] == "Clubs"}
end

def establish_order_of_play_first_trick(dealer, left, across, right)
  order = [dealer, left, across, right]
  first_player_index = order.index {|player| find_two_of_clubs(player) == true}
  case first_player_index
    when 0
      return order
    when 1
      return [left, across, right, dealer]
    when 2
      return [across, right, dealer, left]
    when 3
      return [right, dealer, left, across]
  end
end

def establish_order_of_play(order_of_play, winner)
  first_player_index = order_of_play.index {|player| player == winner}
  case first_player_index
    when 0
      return order_of_play
    when 1
      return [order_of_play[1], order_of_play[2], order_of_play[3], order_of_play[0]]
    when 2
      return [order_of_play[2], order_of_play[3], order_of_play[0], order_of_play[1]]
    when 3
      return [order_of_play[3], order_of_play[0], order_of_play[1], order_of_play[2]]
  end
end

def has_suit?(player, suit)
  player[:hand].any? {|card| card[:suit] == suit}
end



def display_playable_cards(user_player, suit)
  playable_cards = user_player[:hand].select {|card| card[:suit] == suit}
  hand = sort_cards(playable_cards)
  display = "Cards you can play: "
  i = 0
  while i < (hand.length - 1) do
    if (display.length >= 71 && display.length <= 79) || (display.length >= 149 && display.length <= 158)
      display = display + "\n#{i + 1}. #{hand[i][:card]} of #{hand[i][:suit]}, "
    else
      display = display + "#{i + 1}. #{hand[i][:card]} of #{hand[i][:suit]}, "
    end
    i += 1
  end
  display = display + "#{i + 1}. #{hand[i][:card]} of #{hand[i][:suit]}"
  puts "\n"
  puts display
  hand
end

def display_playable_cards_user_leads_hearts_not_played(user_player)
  playable_cards = user_player[:hand].select {|card| card[:suit] != "Hearts"}
  hand = sort_cards(playable_cards)
  display = "Cards you can lead with: "
  i = 0
  while i < (hand.length - 1) do
    if (display.length >= 71 && display.length <= 79) || (display.length >= 149 && display.length <= 158)
      display = display + "\n#{i + 1}. #{hand[i][:card]} of #{hand[i][:suit]}, "
    else
      display = display + "#{i + 1}. #{hand[i][:card]} of #{hand[i][:suit]}, "
    end
    i += 1
  end
  display = display + "#{i + 1}. #{hand[i][:card]} of #{hand[i][:suit]}"
  puts "\n"
  puts display
  hand
end

def remove_played_card_from_hand(player, card)
  card_index = player[:hand].index(card)
  player[:hand].slice!(card_index)
end

def get_selected_card(hand)
  selected_card = gets.strip
  integer_card = selected_card.to_i
  while integer_card > hand.length || integer_card == 0 do
    puts "That's not a valid number"
    selected_card = gets.strip
    integer_card = selected_card.to_i
  end
  integer_card
end

def user_turn(user_player, hearts_played, suit = nil)
  #returns played card
  if suit == nil && hearts_played == true
    hand = display_user_hand(user_player)
    puts "You can play any card to lead"
    puts "Enter the number of the card to play"
    selected_card_int = get_selected_card(hand)
    card_index = selected_card_int - 1
    return remove_played_card_from_hand(user_player, hand[card_index])
  elsif suit == nil && hearts_played == false
    hand = display_user_hand_no_numbers(user_player)
    playable_cards = display_playable_cards_user_leads_hearts_not_played(user_player)
    puts "Enter the number of the card to play"
    selected_card_int = get_selected_card(playable_cards)
    card_index = selected_card_int - 1
    card = playable_cards[card_index]
    return remove_played_card_from_hand(user_player, card)
  elsif has_suit?(user_player, suit) == true
    puts "\n"
    puts "Suit: #{suit}"
    hand = display_user_hand_no_numbers(user_player)
    playable_cards = display_playable_cards(user_player, suit)
    puts "Enter the number of the card to play"
    selected_card_int = get_selected_card(playable_cards)
    card_index = selected_card_int - 1
    card = playable_cards[card_index]
    return remove_played_card_from_hand(user_player, card)
  else
    puts "\n"
    puts "Suit: #{suit}"
    hand = display_user_hand(user_player)
    puts "You can play any card"
    puts "Enter the number of the card to play"
    selected_card_int = get_selected_card(hand)
    card_index = selected_card_int - 1
    return remove_played_card_from_hand(user_player, hand[card_index])
  end
end


#Here begins the auto players' playing strategy functions

def determine_playable_cards(player, suit)
  player[:hand].select {|card| card[:suit] == suit}
end

def playable_cards_no_hearts(player)
  player[:hand].reject {|card| card[:suit] == "Hearts"}
end

def determine_automated_strategy(player)
  #returns which suit the automated players will lead with
  hearts = player[:hand].select {|card| card[:suit] == "Hearts"}
  clubs = player[:hand].select {|card| card[:suit] == "Clubs"}
  diamonds = player[:hand].select {|card| card[:suit] == "Diamonds"}
  spades = player[:hand].select {|card| card[:suit] == "Spades"}
  array_of_suits = [hearts, clubs, diamonds, spades]
  suit_with_most_cards = array_of_suits.max {|a, b| a.length <=> b.length}
  if suit_with_most_cards[0][:suit] == "Hearts" && suit_with_most_cards.length < 7
    array_of_suits.shift
    suit_with_most_cards = array_of_suits.max {|a, b| a.length <=> b.length}
  end
  strategy_hash = {
    :name => player[:name],
    :strategy => suit_with_most_cards[0][:suit]
  }
  strategy_hash
end

def make_strategy_array(order_of_play)
  order_of_play.map {|player| determine_automated_strategy(player)}
end

def auto_lead_with_hearts(player, strategy, original_points_value)
    #find number of hearts and max value
  hearts = determine_playable_cards(player, "Hearts")
  hearts_max_value = hearts.max {|a, b| a[:value] <=> b[:value]}
    #determine number of cards in auto
    #player's strategy suit and max value
  playable_cards_strategy = determine_playable_cards(player, strategy)
  max_value_strategy = playable_cards_strategy.max {|a, b| a[:value] <=> b[:value]}
    #determine max value card in hand
  hand_max_value = player[:hand].max {|a, b| a[:value] <=> b[:value]}
  hand = player[:hand]
  
    #if the player has gained points during current round
    #and if the player's strategy suit is hearts
    #play the highest hearts
    #unless the highest heart has a value of 7 or less
  if (player[:points] - original_points_value) > 0 && strategy == "Hearts"
    if hearts.length > 0 && hearts_max_value[:value] > 7
      card_played = hearts.max {|a, b| a[:value] <=> b[:value]}
    else
      hand_max_value_array = player[:hand].max(4) {|a, b| a[:value] <=> b[:value]}
      index = check_for_high_spades(hand_max_value_array)
      if strategy != "Hearts"
        index = check_for_high_hearts(hand_max_value_array, index)
      end
      card_played = hand_max_value_array[index]
    end
    #player has cards in strategy suit and
    #the strategy max value is larger than 7
  elsif (playable_cards_strategy.length > 0 && max_value_strategy[:value] > 7) && (playable_cards_strategy[0][:suit] == "Diamonds" || playable_cards_strategy[0][:suit] == "Clubs")
    card_played = playable_cards_strategy.max {|a, b| a[:value] <=> b[:value]}
    #player has gained points in current round and
    #does not have very high value cards
  elsif (player[:points] - original_points_value) > 2 && hand_max_value[:value] < 9
    card_played = player[:hand].min {|a, b| a[:value] <=> b[:value]}
  else
    hand_max_value_array = player[:hand].max(4) {|a, b| a[:value] <=> b[:value]}
    index = check_for_high_spades(hand_max_value_array)
    if strategy != "Hearts"
      index = check_for_high_hearts(hand_max_value_array, index)
    end
    card_played = hand_max_value_array[index]
  end
  player[:hand].index(card_played)
end

def check_for_high_hearts(hand_max_value_array, index)
  while hand_max_value_array[index][:suit] == "Hearts" do
    if index == (hand_max_value_array.length - 1)
      break
    end
    index += 1
  end
  index
end

def check_for_high_spades(hand_max_value_array)
  index = 0
  while hand_max_value_array[index][:suit] == "Spades" && hand_max_value_array[index][:value] > 10 do
    if index == (hand_max_value_array.length - 1)
      break
    end
    index += 1
  end
  index
end

def check_strategy_then_play_highest_except_spades(playable_cards, strategy)
  strategized_playable_cards = playable_cards.select {|card| card[:suit] == strategy}
  max_value_strategy = strategized_playable_cards.max {|a, b| a[:value] <=> b[:value]}
  if (strategized_playable_cards.length > 0 && max_value_strategy[:value] > 8) && strategized_playable_cards[0][:suit] != "Spades"
    card_played = strategized_playable_cards.max {|a, b| a[:value] <=> b[:value]}
  else
    playable_cards.concat(strategized_playable_cards)
    hand_max_value_array = playable_cards.max(4) {|a, b| a[:value] <=> b[:value]}
    index = check_for_high_spades(hand_max_value_array)
    card_played = hand_max_value_array[index]
  end
end

def auto_lead_with_no_hearts(player, strategy, trick_number)
  playable_cards = playable_cards_no_hearts(player)
  playable_max_value = playable_cards.max {|a, b| a[:value] <=> b[:value]}
  if strategy == "Hearts" && playable_max_value[:suit] != "Spades"
    card_played = playable_cards.max {|a, b| a[:value] <=> b[:value]}
  elsif playable_max_value[:value] > 11 && (playable_max_value[:suit] == "Clubs" || playable_max_value[:suit] == "Diamonds")
    card_played = playable_max_value
  else
    card_played = check_strategy_then_play_highest_except_spades(playable_cards, strategy)
  end
  player[:hand].index(card_played)
end

def queen_spades_played?(played_cards)
  queen_of_spades = return_queen_spades
  played_cards.any?{|card| card == queen_of_spades}
end

def auto_no_lead_has_suit(player, suit, original_points_value, trick_number, played_cards)
  playable_cards = determine_playable_cards(player, suit)
  number_of_cards_played = played_cards.length
  played_cards_in_suit = played_cards.select {|card| card[:suit] == suit}
  highest_played_card_in_suit = played_cards_in_suit.max {|a, b| a[:value] <=> b[:value]}
  played_hearts = played_cards.select {|card| card[:suit] == "Hearts"}
  queen_of_spades_played =  queen_spades_played?(played_cards)
  if (player[:points] - original_points_value) > 12
    card_played = playable_cards.max {|a, b| a[:value] <=> b[:value]}
  elsif suit == "Spades"
    cards_to_play = playable_cards.select {|card| card[:value] < 11}
    adjusted_cards_to_play = cards_to_play.select {|card| card[:value] < highest_played_card_in_suit[:value]}
    if played_hearts.length > 0 && adjusted_cards_to_play.length > 0
      card_played = adjusted_cards_to_play.max {|a, b| a[:value] <=> b[:value]}
    elsif cards_to_play.length > 0
      card_played = cards_to_play.max {|a, b| a[:value] <=> b[:value]}
    else
      card_played = playable_cards.max {|a, b| a[:value] <=> b[:value]}
    end
  elsif suit == "Clubs" || suit == "Diamonds"
    if played_hearts.length > 0 || queen_of_spades_played == true
      cards_to_play = playable_cards.select {|card| card[:value] < highest_played_card_in_suit[:value]}
      if cards_to_play.length > 0
        card_played = cards_to_play.max {|a, b| a[:value] <=> b[:value]}
      else
        card_played = playable_cards.max {|a, b| a[:value] <=> b[:value]}
      end
    else
      card_played = playable_cards.max {|a, b| a[:value] <=> b[:value]}
    end
  else
    cards_to_play = playable_cards.select {|card| card[:value] < highest_played_card_in_suit[:value]}
    if cards_to_play.length > 0
      card_played = cards_to_play.max {|a, b| a[:value] <=> b[:value]}
    else
      card_played = playable_cards.max {|a, b| a[:value] <=> b[:value]}
    end
  end
  player[:hand].index(card_played)
end

def return_queen_spades
  {:card => "Queen", :suit => "Spades", :value => 11, :points => 13}
end

def any_queen_spades(player)
  queen_of_spades = return_queen_spades
  player[:hand].any?{|card| card == queen_of_spades}
end

def auto_no_lead_no_suit(player, strategy)
  any_hearts = player[:hand].any? {|card| card[:suit] == "Hearts"}
  queen_of_spades_any = any_queen_spades(player)
  if queen_of_spades_any
    card_played = return_queen_spades
  elsif any_hearts
    hearts = player[:hand].select {|card| card[:suit] == "Hearts"}
    card_played = hearts.max {|a, b| a[:value] <=> b[:value]}
  else
    hand = player[:hand]
    non_strat_cards = hand.select {|card| card[:suit] != strategy}
    strategy_cards = hand.select {|card| card[:suit] == strategy}
    if strategy_cards.length < 3 && strategy_cards.length > 0
      card_played = strategy_cards.max {|a, b| a[:value] <=> b[:value]}
    elsif strategy_cards.length > 6 && non_strat_cards.length > 0
      card_played = non_strat_cards.min {|a, b| a[:value] <=> b[:value]}
    elsif strategy_cards.length > 0 && non_strat_cards.length == 0
      card_played = strategy_cards.min {|a, b| a[:value] <=> b[:value]}
    else
      card_played = non_strat_cards.max {|a, b| a[:value] <=> b[:value]}
    end
  end
  player[:hand].index(card_played)
end

def automated_play(player, hearts_played, strategy, original_points_value, trick_number, played_cards, suit = nil)
  if suit == nil && hearts_played == true
    card_index = auto_lead_with_hearts(player, strategy, original_points_value)
    return remove_played_card_from_hand(player, player[:hand][card_index])
  elsif suit == nil && hearts_played == false
    card_index = auto_lead_with_no_hearts(player, strategy, trick_number)
    return remove_played_card_from_hand(player, player[:hand][card_index])
  elsif has_suit?(player, suit) == true
    card_index = auto_no_lead_has_suit(player, suit, original_points_value, trick_number, played_cards)
    return remove_played_card_from_hand(player, player[:hand][card_index])
  else
    card_index = auto_no_lead_no_suit(player, strategy)
    return remove_played_card_from_hand(player, player[:hand][card_index])
  end
end

#end of auto play functions


def display_card_played(player, card_played)
  if player[:name] == "User"
    puts "    You played the #{card_played[:card]} of #{card_played[:suit]}"
  else
    puts "    #{player[:name]} played the #{card_played[:card]} of #{card_played[:suit]}"
  end
end

def determine_winner(played_cards, suit)
  #returns index of winning card
  cards_in_suit = played_cards.select {|card| card[:suit] == suit}
  winning_card = cards_in_suit.max {|a, b| a[:value] <=> b[:value]}
  played_cards.index(winning_card)
end

def determine_number_of_points(played_cards)
  total_points = 0
  played_cards.each {|card| total_points += card[:points]}
  total_points
end

def display_point_totals(order_of_play)
  puts "\n"
  puts "POINT TOTALS"
  order_of_play.each do |player|
    puts "#{player[:name]} points: #{player[:points]}"
  end
end

def display_point_totals_during_round(order_of_play, original_points_round)
  puts "\n"
  puts "POINTS THIS ROUND"
  order_of_play.each_with_index do |player, index|
    puts "#{player[:name]} points: #{player[:points] - original_points_round[index][:points]}"
  end
end

def was_heart_played(played_cards)
  played_cards.any? {|card| card[:suit] == "Hearts"}
end

def trick(order_of_play, hearts_played, strategy_array, trick_number, original_points_round)
  #returns array with winner and boolean value for hearts_played
  puts "\n"
  original_points_trick = original_points_array(order_of_play)
  user_index = order_of_play.index {|player| player[:name] == "User"}
  played_cards = []
  suit = nil
  order_of_play.each_with_index do |player, index|
    if trick_number == 1 && index == 0
      card_index = order_of_play[index][:hand].index({:card => "2", :suit => "Clubs", :value => 1, :points => 0})
      card_played = remove_played_card_from_hand(order_of_play[index], order_of_play[index][:hand][card_index])
    elsif index == user_index && index == 0
      card_played = user_turn(order_of_play[index], hearts_played)
    elsif index == user_index
      card_played = user_turn(order_of_play[index], hearts_played, suit)
    elsif index != user_index && index == 0
      card_played = automated_play(order_of_play[index], hearts_played, strategy_array[index][:strategy], original_points_trick[index][:points], trick_number, played_cards)
    else
      card_played = automated_play(order_of_play[index], hearts_played, strategy_array[index][:strategy], original_points_trick[index][:points], trick_number, played_cards, suit,)
    end
    if index == 0
      suit = card_played[:suit]
    end
    display_card_played(order_of_play[index], card_played)
    played_cards << card_played
  end
  winner_index = determine_winner(played_cards, suit)
  winner = order_of_play[winner_index]
  points = determine_number_of_points(played_cards)
  puts "#{winner[:name]} took the trick with a point value of #{points}"
  winner[:points] += points
  display_point_totals_during_round(order_of_play, original_points_round)
  heart_tf = was_heart_played(played_cards)
  if heart_tf == true
    puts "\n"
    puts "[Hearts have broken]"
  end
  [winner, heart_tf]
end

def original_points_array(order_of_play)
  array = order_of_play.map do |player|
    {:name => player[:name], :points => player[:points]}
  end
  array
end

def re_order_original_points_array(order_of_play, original_points_array)
  re_order = []
  original_points_array.each do |points_player|
    new_index = order_of_play.index {|player| player[:name] == points_player[:name]}
    re_order[new_index] = points_player
  end
  re_order
end

def re_order_strategy_array(order_of_play, strategy_array)
  re_order = []
  strategy_array.each do |strategy_player|
    new_index = order_of_play.index {|player| player[:name] == strategy_player[:name]}
    re_order[new_index] = strategy_player
  end
  re_order
end


def shoot_the_moon(order_of_play, original_points)
  point_differences = []
  order_of_play.each_with_index do |player, index|
    difference = player[:points] - original_points[index][:points]
    point_differences << difference
  end
  point_differences.index(26)
end

def moon_shot_points_update(order_of_play, shot_the_moon_index)
  order_of_play.each_with_index do |player, index|
    if index == shot_the_moon_index
      player[:points] -= 26
    else
      player[:points] += 26
    end
  end
end

def round(array_of_players, deck_array, round)
  dealer = array_of_players[0]
  left = array_of_players[1]
  across = array_of_players[2]
  right = array_of_players[3]
  
  deal(dealer, left, across, right, deck_array)
  order_of_play = establish_order_of_play_first_trick(dealer, left, across, right)
  strategy_array = make_strategy_array(order_of_play)
  original_points = original_points_array(order_of_play)
  hearts_played = false
  trick_number = 1
  13.times do
    array_with_winner_and_hearts_played = trick(order_of_play, hearts_played, strategy_array, trick_number, original_points)
    winner = array_with_winner_and_hearts_played[0]
    if hearts_played == false
      hearts_played = array_with_winner_and_hearts_played[1]
    end
    order_of_play = establish_order_of_play(order_of_play, winner)
    original_points = re_order_original_points_array(order_of_play, original_points)
    strategy_array = re_order_strategy_array(order_of_play, strategy_array)
    trick_number += 1
  end
  shot_the_moon_index = shoot_the_moon(order_of_play, original_points)
  if shot_the_moon_index
    puts "\n"
    puts "#{order_of_play[shot_the_moon_index][:name]} shot the moon!"
    moon_shot_points_update(order_of_play, shot_the_moon_index)
  end
  puts "\n"
  puts "END OF ROUND #{round}"
  display_point_totals(order_of_play)
end

def check_points(array_of_players)
  array_of_players.any? {|player| player[:points] > 70}
end

def copy_deck(deck_of_cards)
  deck_of_cards.map {|card| card}
end
  
def runner(user_player, charlie_player, susan_player, kendra_player, deck_of_cards)
  welcome
  
  updated_deck = copy_deck(deck_of_cards)
  array_of_players = dealer_order_array(user_player, charlie_player, susan_player, kendra_player)
  game_over_points = check_points(array_of_players)
  round = 1
  
  while game_over_points == false do
    puts "\n"
    puts "ROUND #{round}"
    puts "#{array_of_players[0][:name]} is the dealer"
    round(array_of_players, updated_deck, round)
    game_over_points = check_points(array_of_players)
    array_of_players = change_dealer(array_of_players)
    updated_deck = copy_deck(deck_of_cards)
    round += 1
  end
  puts "The game is over"
  winner = array_of_players.min {|a, b| a[:points] <=> b[:points]}
  puts "#{winner[:name]} is the winner!"
end

runner(user_player, charlie_player, susan_player, kendra_player, deck_of_cards)