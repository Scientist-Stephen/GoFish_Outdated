require_relative 'FishDeck.rb'
require_relative 'FishHand.rb'
require_relative 'FishGame.rb'

describe FishDeck do

	before(:all) do
    	@deck = FishDeck.new
	end


	it "exists and has 52 shuffled cards" do							#GOOD
		@deck.class.should_not eq(nil)
		@deck.all_cards.should have(52).items
		#puts "all cards are:#{@deck.all_cards}"	#Shows cards are shuffled
	end

	it "returns one card popped off the top of the deck (array)" do		#GOOD
		@deck.pop_top_card
		@deck.all_cards.should have(51).items
	end


end	######THIS end is really, REALLEALLLY important.  It's the end of describe FishDeck do



describe FishHand do
 
 	before(:all) do
    	#@player1 = FishHand.new	#I initialized these
    	#@player2 = FishHand.new	#somewhere else.
    	#@player3 = FishHand.new	#Oh, it was in FishGame!
    	#@player4 = FishHand.new
    	#@player5 = FishHand.new	#This are instances fishand there, too
    	@game = FishGame.new
    	@deck = FishDeck.new
	end


	it "exists" do
		
		@player1.class.should_not eq(nil)
	end


	it "holds a player's cards dealt by the game" do

		@game.deal_to_players(@deck, @game.player1, @game.player2, @game.player3, @game.player4, @game.player5)
		@game.player1.player_cards.should have(5).items
	#	puts @game.player1.player_cards
	end

	it "looks for books, deletes them, and update books collected" do
		@game.player1.player_cards = %w(2 4 7 3 J 7 J 9 7 4 J 7 J)
		#puts @game.player1.player_cards
	
		@game.player1.looks_for_books
		@game.player1.books_collected.should eq(2)
		#puts @game.player1.books_collected
		#puts @game.player1.player_cards
	
		@game.player1.player_cards.should_not include("J")
		@game.player1.player_cards.should_not include("J")
	end
=begin
	it "returns requested card and deletes from player card, else returns empty array (nil?)" do
		
		@game.player1.player_cards = %w(2 3 K A K)
		requested_card = @game.player1.return_cards_requested("A")	#retreiving and deleting one cards
		@game.player1.player_cards.should eq(%w(2 3 K K))
		requested_card.should eq(["A"])

		@game.player1.player_cards = %w(2 3 K A K)
		@game.player1.return_cards_requested("K")	#retreving and deleting multiple cards
		@game.player1.player_cards.should eq(%w(2 3 A))
	end
=end
end



describe FishHand do
 
 	before(:all) do
    	#@player1 = FishHand.new	#I initialized these
    	#@player2 = FishHand.new	#somewhere else.
    	#@player3 = FishHand.new	#Oh, it was in FishGame!
    	#@player4 = FishHand.new
    	#@player5 = FishHand.new	#This are instances fishand there, too
    	@game = FishGame.new
    	@deck = FishDeck.new
	end


	it "exists" do
		
		@game.class.should_not eq(nil)
	end

	it "initializes Hands" do
		
		@game.player1.should_not eq(nil)
		@game.player5.should_not eq(nil)
	end


	it "deals cards to hands" do

		@game.deal_to_players(@deck, @game.player1, @game.player2, @game.player3, @game.player4, @game.player5)
		@game.player1.player_cards.should have(5).items
		@game.player5.player_cards.should have(5).items
	end


end




describe FishGame do

	before(:all) do
    	@game = FishGame.new
    	@deck = FishDeck.new	#PUT THE DECK IN THE GAME
	end


	it "gives deck top card a specific hand and initiates finds book in that hand" do
		
		@game.player1.player_cards = %w(3 5 7 3 7 8)
				@game.deck_to_player(@deck, @game.player1)
		
		@deck.all_cards.size.should eq(51)	#one came off the deck
		@game.player1.player_cards.size.should eq(7)	#and was added to player_cards

	end


	it "takes a card of rank x from player_y to player_z" do

		@game.player1.player_cards = %w(2 3 5 K A J)
		@game.player2.player_cards = %w(4 6 A Q J 9)
		
		@game.player_to_player(@deck, "Q", @game.player2, @game.player1)

		@game.player1.player_cards.size.should eq(7)
		@game.player2.player_cards.size.should eq(5)
		#No cards found in other array
	end


	it "takes two or more cards of rank x from player_y to player_z" do

		@game.player1.player_cards = %w(2 3 5 K A K)
		@game.player2.player_cards = %w(4 6 A Q J Q)

		@game.player_to_player(@deck, "Q", @game.player2, @game.player1)

		@game.player1.player_cards.size.should eq(8)
		@game.player2.player_cards.size.should eq(4)	
	end

	it "takes finds no card x from player_y to player_z" do

		@game.player1.player_cards = %w(2 3 5 K A J)
		@game.player2.player_cards = %w(4 6 A Q J 9)
		
		@game.player_to_player(@deck, "Q", @game.player2, @game.player1)

		@game.player1.player_cards.size.should eq(7)
		@game.player2.player_cards.size.should eq(5)
	end


	it "player_to_player does not find and cards of rank x from player_y to player_z" do

		@game.player1.player_cards = %w(2 3 5 K A J)
		@game.player2.player_cards = %w(4 6 A Q J 9)
		
		@game.player_to_player(@deck, "7", @game.player1, @game.player2)

	#	puts "Player1 card size: #{@game.player1.player_cards.size}"
	#	puts "Player2 card size: #{@game.player2.player_cards.size}"
		@game.player1.player_cards.size.should eq(6)
		@game.player2.player_cards.size.should eq(7)
	end
end

