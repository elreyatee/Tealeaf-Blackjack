# Ellery Temple Jr.
# 10/20/14
# Lesson 1 - Blackjack 

require 'pry'

# create a deck of cards
def deck_of_cards
  deck  = [] #empty deck, needs to be 52 cards total
  suits = %w{'spade', 'club', 'heart', 'diamond'}
  ranks = %w{'Ace', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King'}

  suits.each do |suit|
    ranks.each_with_index do |rank, index|
      index = 9 if index > 9 # max value on card is 10
      deck << {'rank' => rank, 'suit' => suit, 'value' => index + 1}
    end
  end
  deck
end

def hand_to_s(d)
  string = []
  d.each do |card|
    string << "#{card['rank']} of #{card['suit']}"
  end
  string.join
end

# shuffle the deck of cards
def shuffle_deck(d)
  d.shuffle!
end

def check_value(d)
  sum = 0
  d.each do |card|
    sum += card.values.last
  end
  sum
end

def deal_card(d)
  d.pop
end

def player_round(h, d)
  puts "Your cards are #{hand_to_s(h)}. Your total value is #{check_value(h)}"
  case
  when check_value(h) == 21
    puts "Blackjack!"
  when check_value(h) > 21
    puts "You're busted. You lost."
  when check_value(h) < 21
    print "Would you like a hit or stay? (H/S)"
    player_choice = gets.chomp.downcase

    if player_choice == 'h'
      h << deal_card(d)
      player_round(h, d)
    end
  end
  final_value = check_value(h)
end

def dealer_round(h, d)
  puts "The dealer's cards are #{hand_to_s(h)}. Their total value is #{check_value(h)}"
  case 
  when check_value(h) == 21
    puts "Dealer has Blackjack!"
  when check_value(h) > 21
    puts "Dealer has busted. You won."
  when check_value(h) <= 13
    puts "Dealer takes a hit"
    h << deal_card(d)
    dealer_round(h, d)
  when check_value(h) > 13 && check_value(h) < 21
    puts "Dealer stays"
  end
  final_value = check_value(h)
end

def winner(p, d)
  if p > d && p < 21 && d < 21
    puts "You win!"
  elsif p < d && d < 21 && p < 21
    puts "You lose!"
  elsif p == d
    puts "Push"
  end
end

def blackjack
  deck = deck_of_cards 

  begin 
    puts "Welcome to Blackjack"
    shuffle_deck(deck)

    # deal player two cards, and deal computer two cards
    player_hand = []
    dealer_hand = []

    player_hand << deal_card(deck)
    dealer_hand << deal_card(deck)
    player_hand << deal_card(deck)
    dealer_hand << deal_card(deck)

    player_value = player_round(player_hand, deck)

    if player_value <= 21
      dealer_value = dealer_round(dealer_hand, deck)
      winner(player_value, dealer_value)
    end

    puts "Would you like to play again? (Y/N)"
    play_again = gets.chomp.downcase
  end until play_again == 'n'

  puts "Thanks for playing"
end

blackjack






    


