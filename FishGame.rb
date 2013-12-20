require_relative 'FishDeck.rb'
require_relative 'FishHand.rb'


class FishGame

	attr_accessor :player1
	attr_accessor :player2
	attr_accessor :player3
	attr_accessor :player4
	attr_accessor :player5
	attr_accessor :top_card_container, :next_turn	#next turn stores who's turn it is next
	attr_accessor :hands						#How will I use that with the server?

	def initialize 	#Probably a better way to initiate players, like
					#initiating them and associeting them with clients
		@player1 = FishHand.new	#need to initialize CLIENTS.  
    	@player2 = FishHand.new	#When a CLIENT is initialize, they will have 
    	@player3 = FishHand.new #A FISHHAND
    	@player4 = FishHand.new
    	@player5 = FishHand.new
    	@hands = [@player1, @player2, @player3, @player4, @player5]   
     	

     	@next_turn = "player1"	#Probably going to need array and this will be the position
    							#Remeber to change it elsewhere, as in player_to_player

    #create players class that can take a socket.  #Later!  I'm confused and am going to use a hash right now...
	end

	def deal_to_players(deck_name, player1 = nil, player2 = nil, player3 = nil, player4 = nil, player5 = nil)	#And "players" are really FishHand instances
		
		5.times do
			top_card = deck_name.pop_top_card
			@player1.player_cards << top_card

			top_card = deck_name.pop_top_card
			@player2.player_cards << top_card

			top_card = deck_name.pop_top_card
			@player3.player_cards << top_card

			top_card = deck_name.pop_top_card
			@player4.player_cards << top_card

			top_card = deck_name.pop_top_card
			@player5.player_cards << top_card
		end
	end

	def deck_to_player(game_deck, player_to)
	
		player_to.player_cards << top_card_container = game_deck.pop_top_card
		#Pops top deck card and shovels onto player_to 's cards
		player_to.looks_for_books
	end


	def player_to_player(game_deck, wanted_card, player_asked, player_asking)	#player_asking wants "wanted_card" from player_asked

		card_holder = player_asked.return_cards_requested(wanted_card)	#player in game's return card method and stores

		#puts "card holder[0] is: #{card_holder[0]}"
		#puts "wanted card is #{wanted_card}"


		if card_holder[0] == wanted_card	#element 0 will be the wanted_card or hold nothing
			
			player_asking.player_cards.concat(card_holder)
			card_holder.clear
			player_asking.looks_for_books
			@next_turn = "player_asking"
			#puts "next turn if player_asked has player_asking \'s wanted card"
		else
			
			card_from_deck = deck_to_player(game_deck, player_asking)
			
			if card_from_deck == wanted_card 
				@next_turn = "player_asking"
	#			puts "next turn if card from deck == card wanted: #{@next_turn}"
			else
				@next_turn = "NEXT PLAYER"
	#			puts "next turn if card from deck did NOT == card wanted: #{@next_turn}"
			end
		end
	end
end
