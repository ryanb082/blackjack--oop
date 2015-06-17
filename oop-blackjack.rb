require 'pry'

class Card
  attr_accessor :suit, :face_value # allows to call method and modify Best Practice: You never want to access the instance variable directly

  def initialize(s, fv) # Arguments to the method
    @suit = s
    @face_value = fv 
  end

  def pretty_output
     "#{face_value} of #{find_suit}"
  end

  def to_s
    pretty_output
  end

  def find_suit
    ret_val = case suit
                when 'H' then 'Hearts'
                when 'D' then 'Diamonds'
                when 'S' then 'Spades'
                when 'C' then 'Clubs'
              end
    ret_val
  end
end

# Deck Class

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    ['H', 'D', 'S', 'C'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].each do |face_value|
        @cards << Card.new(suit, face_value)
      end
    end
    scramble!
  end

  def scramble!
    cards.shuffle! 
  end

  def deal_one
    cards.pop #pop method comes from array, takes off last element and returns it
  end

  def size
    cards.size
  end
end

# Hand Module

module Hand
  def show_hand
    puts "---- #{name}'s Hand ----"
    cards.each do|card|
      puts "=> #{card}"
    end
    puts "=> Total: #{total}"
  end

  def total
    face_values = cards.map{|card| card.face_value }

    total = 0
    face_values.each do |val|
      if val == "A"
        total += 11
      else
        total += (val.to_i == 0 ? 10 : val.to_i)
      end
    end

    #correct for Aces
    face_values.select{|val| val == "A"}.count.times do
      break if total <= 21
      total -= 10
    end

    total
  end

  def add_card(new_card)

    cards << new_card

  end
end

# Player Class

class Player
  include Hand

  attr_accessor :name, :cards

  def initialize(n)
    @name = n
    @cards = []
  end

end

# Dealer Class

class Dealer
  include Hand

  attr_accessor :name, :cards

  def intialize
    @name = "Dealer"
    @cards = []
  end

end





deck = Deck.new

 player = Player.new("Ryan")
 player.add_card(deck.deal_one)
 player.add_card(deck.deal_one)
 player.show_hand
 
 dealer = Dealer.new
 dealer.add_card(deck.deal_one)
 dealer.add_card(deck.deal_one)
 dealer.show_hand



