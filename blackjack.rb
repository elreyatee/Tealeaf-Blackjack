# Ellery Temple Jr.
# 10/20/14
# Lesson 1 - Blackjack 

require 'pry'

# create a deck of cards
def deck_of_cards
  deck  = [] #empty deck, needs to be 52 cards total
  #suits = %w{Spades Clubs Hearts Diamonds}
  suits = ["\u2660", "\u2663", "\u2665", "\u2666"]
  ranks = %w{Ace 2 3 4 5 6 7 8 9 10 Jack Queen King}

  suits.each do |suit|
    ranks.each_with_index do |rank, index|
      index = 9 if index > 9 # max value on card is 10
      deck << {'rank' => rank, 'suit' => suit, 'value' => index + 1}
    end
  end
  deck
end

# print to screen format for a hand
def hand_to_s(hand)
  string = []
  if hand.length > 1
    hand.each do |card|
      string << "#{card['rank']} of #{card['suit'].encode('utf-8')}"
    end
    string.join(' and ')
  else
    string
  end
end

# shuffle the deck of cards
def shuffle_deck(deck)
  puts ".....Shuffling cards....."
  5.times do
    print "..."
    sleep 1 # 5 total seconds to shuffle cards
  end
  deck.shuffle! #mutates the caller
end

# check value of cards in a hand
def check_value(hand)
  sum = 0
  hand.each do |card|
    sum += card.values.last
  end
  sum
end

# deal a card from deck (mutates the caller)
def deal_card(deck)
  deck.pop
end

# player round
def player_round(hand, deck, name)
  puts "Your cards are #{hand_to_s(hand)}. Your total value is #{check_value(hand)}"
  case
  when check_value(hand) == 21 || check_value(hand) == 11 # One of the cards is an Ace
    puts "You got Blackjack!"
  when check_value(hand) > 21
    puts "Sorry #{name}, you're busted!"
  when check_value(hand) < 21
    print "Would you like a hit or stay #{name}? (H/S)"
    player_choice = gets.chomp.downcase

    if player_choice == 'h'
      hand << deal_card(deck)
      player_round(hand, deck, name)
    end
  end
  final_value = check_value(hand)
end

# dealer round
def dealer_round(hand, deck)
  puts "The dealer's cards are #{hand_to_s(hand)}. Their total value is #{check_value(hand)}"
  case 
  when check_value(hand) == 21 || check_value(hand) == 11 # One of the cards is an Ace
    puts "Dealer has Blackjack!"
  when check_value(hand) > 21
    puts "Dealer has busted. You won!"
  when check_value(hand) >= 17 && check_value(hand) < 21
    sleep 1
    puts "=> Dealer stays"
  when check_value(hand) < 17
    puts "=> Dealer takes a hit"
    sleep 1
    hand << deal_card(deck)
    dealer_round(hand, deck)
  end
  final_value = check_value(hand)
end

# determine winner cases
def winner(player, dealer)
  case
  when (player == 21 && dealer < 21) || (player > dealer && player < 21 && dealer < 21) 
    puts "You win!"
  when (dealer == 21 && player < 21) || (player < dealer && dealer < 21 && player < 21)
    puts "You lose!"
  when player == dealer
    puts "Push"
  end
end

# play blackjack
def play_blackjack

  # welcome player
  puts "Welcome to Blackjack!"
  print "Howdy stranger, what's your name? "

  # get player's name
  name = gets.chomp

  puts "Nice to meet you #{name}. Let's play some Blackjack!"

  begin 
    deck = []

    # three decks of cards protects against card counting
    3.times {deck += deck_of_cards} 
    shuffle_deck(deck)
    
    # players have yet to be dealt cards
    player_hand = []
    dealer_hand = []

    # deal cards in an alternate manner
    2.times do
      player_hand << deal_card(deck)
      dealer_hand << deal_card(deck)
    end

    # show dealer's face up card, which is the last card dealt
    puts "Dealer's face up card is a #{dealer_hand.last['rank']} of #{dealer_hand.last['suit'].encode('utf-8')}"

    player_value = player_round(player_hand, deck, name)

    # dealer only plays out hand when player does not bust. If players busts, they automatically lose
    if player_value <= 21 
      dealer_value = dealer_round(dealer_hand, deck)
      winner(player_value, dealer_value)
    end

    # ask player to play again
    print "Would you like to play again? (Y/N) "
    play_again = gets.chomp.downcase

    system 'clear' # clear screen out before playing again
  end until play_again == 'n'

  puts "Thanks for playing #{name}!"
end

play_blackjack






    


