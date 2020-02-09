def welcome
  puts "Welcome to the Blackjack Table"
  puts "Press ENTER to deal"
end

def deal_card(deck_array)
  card_index = rand(deck_array.length - 1).round
  deck_array.slice!(card_index)
end

def adjust_total_for_aces(total_without_aces, aces_integers)
  i = 0
  aces_total = aces_integers.sum
  card_total = total_without_aces + aces_total
  while card_total > 21 && i < aces_integers.length do
    aces_integers[i] = 1
    aces_total = aces_integers.sum
    card_total = total_without_aces + aces_total
    i += 1
  end
  card_total
end

def card_total(hand_array)
  numbers = hand_array.select {|card| card.to_i > 0}
  face_cards = hand_array.select {|card| card.length > 3}
  aces = hand_array.select {|card| card == "Ace"}
  
  numbers_integers = numbers.map {|card| card.to_i}
  face_cards_integers = face_cards.map {|card| 10}
  aces_integers = aces.map {|card| 11}
  
  numbers_sum = numbers_integers.sum
  face_cards_sum = face_cards_integers.sum
  aces_sum = aces_integers.sum
  
  total_without_aces = numbers_sum + face_cards_sum
  card_total = total_without_aces + aces_sum
  
  if card_total > 21 && aces.length > 0
    new_total = adjust_total_for_aces(total_without_aces, aces_integers)
    return new_total
  end
  card_total
end

def display_user_hand(user_hand)
  user_hand_display = "Your cards: "
  i = 0
  while i < (user_hand.length - 1) do
    user_hand_display += "#{user_hand[i]}, "
    i += 1
  end
  user_hand_display += "#{user_hand[i]}"
  puts user_hand_display
end

def display_user_card_total(user_hand)
  user_total = card_total(user_hand)
  puts "Your cards add up to #{user_total}"
end

def display_dealer_hand(dealer_hand)
  dealer_hand_display = "Dealer is showing: "
  i = 1
  while i < (dealer_hand.length - 1) do
    dealer_hand_display += "#{dealer_hand[i]}, "
    i += 1
  end
  dealer_hand_display += "#{dealer_hand[i]}"
  puts dealer_hand_display
end

def display_hands(user_hand, dealer_hand)
  display_dealer_hand(dealer_hand)
  display_user_hand(user_hand)
  display_user_card_total(user_hand)
end

def display_dealer_hand_end(dealer_hand)
  dealer_hand_display = "Dealer's cards: "
  i = 0
  while i < (dealer_hand.length - 1) do
    dealer_hand_display += "#{dealer_hand[i]}, "
    i += 1
  end
  dealer_hand_display += "#{dealer_hand[i]}"
  puts dealer_hand_display
end

def display_dealer_card_total(dealer_hand)
  dealer_total = card_total(dealer_hand)
  puts "The dealer's cards add up to #{dealer_total}"
end

def display_hands_end(user_hand, dealer_hand)
  display_dealer_hand_end(dealer_hand)
  display_dealer_card_total(dealer_hand)
  display_user_hand(user_hand)
  display_user_card_total(user_hand)
end

def prompt_user
  puts "Type 'h' to hit or 's' to stay"
end

def get_user_input
  gets.chomp
end

def end_game(user_hand, dealer_hand, updated_deck)
  user_total = card_total(user_hand)
  if user_total > 21
    puts "You busted! Dealer wins"
    return
  end
  
  dealer_total = card_total(dealer_hand)
  while dealer_total < 17 do
    dealer_hand = dealer_play(dealer_hand, updated_deck)
    dealer_total = card_total(dealer_hand)
  end
  
  display_hands_end(user_hand, dealer_hand)
  
  if dealer_total > 21
    puts "The dealer busted! You win!"
  elsif user_total > dealer_total
    puts "You Win!"
  else
    puts "You lost!"
  end
end

def initial_round(deck_array)
  card1 = deal_card(deck_array)
  card2 = deal_card(deck_array)
  [card1, card2]
end

def hit(user_hand, deck_array)
  new_card = deal_card(deck_array)
  user_hand << new_card
  user_hand
end

def dealer_play(dealer_hand, deck_array)
  dealer_total = card_total(dealer_hand)
  if dealer_total < 17
    new_card = deal_card(deck_array)
    dealer_hand << new_card
  end
  dealer_hand
end

def invalid_command
  puts "Please enter a valid command"
end

#####################################################
# get every test to pass before coding runner below #
#####################################################

def runner(deck_array)
  updated_deck = deck_array
  welcome
  gets
  
  dealer_hand = initial_round(updated_deck)
  user_hand = initial_round(updated_deck)
  display_hands(user_hand, dealer_hand)
  
  prompt_user
  user_response = get_user_input
  
  until user_response == "s"
    if user_response == "h"
      user_hand = hit(user_hand, updated_deck)
      dealer_hand = dealer_play(dealer_hand, updated_deck)
      user_total = card_total(user_hand)
      dealer_total = card_total(dealer_hand)
      if dealer_total > 21 || user_total > 21
        display_hands(user_hand, dealer_hand)
        break
      end
    else
      invalid_command
    end
    display_hands(user_hand, dealer_hand)
    prompt_user
    user_response = get_user_input
  end
  
  end_game(user_hand, dealer_hand, updated_deck)
end
    
