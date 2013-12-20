require 'socket'
require 'rspec'
require_relative 'FishDeck.rb'
require_relative 'FishHand.rb'
require_relative 'FishGame.rb'
require_relative 'FishServer.rb'
require_relative 'MockClient.rb'

describe GoFishSocketServer do
	
	before do
		@server = GoFishSocketServer.new
	end

	after do
		@server.close	
	end

	context "Basic set up" do

		it "listens on port 3333 when started" do
			expect{TCPSocket.new('localhost', 3333 )}.to_not raise_error
		end
	end


	context "connecting clients" do
		it "accepts multiple clients" do
			client1 = TCPSocket.new('localhost', 3333)
			@server.accept_client
	
			client2 = TCPSocket.new('localhost', 3333)
			@server.accept_client

			#puts @server.clients

			@server.clients #.count.to equal(1)
		end


		it "Connects clients to hands" do
			

			client1 = MockClient.new
			client2 = MockClient.new 
			client3 = MockClient.new
			client4 = MockClient.new
			client5 = MockClient.new

			@server.accept_client
			@server.accept_client
			@server.accept_client
			@server.accept_client
			@server.accept_client

			deck = FishDeck.new

			player_link = {@server.clients[0] => @server.game.hands[0], @server.clients[1] => @server.game.hands[1], @server.clients[2] => @server.game.hands[2], @server.clients[3] => @server.game.hands[3], @server.clients[4] => @server.game.hands[4]}
			#I just linked the CLIENTS/SOCKETS with the PLAYERS/HANDS here^!		
			
			player_link[@server.clients[0]].should eq(@server.game.hands[0])
			player_link[@server.clients[0]].should eq(@server.game.player1)

			player_link[@server.clients[4]].should eq(@server.game.hands[4])
			player_link[@server.clients[4]].should eq(@server.game.player5)

    	#DEAL:#	@server.game.deal_to_players(deck, @server.game.player1, @server.game.player2, @server.game.player3, @server.game.player4, @server.game.player5)			puts "Player1 cards: #{@server.game.player1.player_cards}"

		#	puts "player_link[@server.clients[0]] : #{player_link[@server.clients[0]]}"
		#	puts "player_link[@server.game.hands[0]] : #{player_link[@server.game.hands[0]]}"

		end





			
	end




	context "Listening" do

		
		before do
			@server = GoFishSocketServer.new
		end

		after do
			#nothing, really.
		end
		
		it "Receives input from a client" do
			client1 = MockClient.new
			client2 = MockClient.new 
			client3 = MockClient.new
			client4 = MockClient.new
			client5 = MockClient.new

			@server.accept_client
			@server.accept_client
			@server.accept_client
			@server.accept_client
			@server.accept_client

			player_link = {@server.clients[0] => @server.game.hands[0], @server.clients[1] => @server.game.hands[1], @server.clients[2] => @server.game.hands[2], @server.clients[3] => @server.game.hands[3], @server.clients[4] => @server.game.hands[4]}
			#I just linked the CLIENTS/SOCKETS with the PLAYERS/HANDS here^!		
			
			
			input = @server.accept_input_from(player_link[0])
			client1.output_to_server("read me?") 
		    puts "INPUT FROM CLIENT1 : #{input}"

		end
	

		#player1_hand.take_cards([PlayingCard.new( 'A', "s")])
		#@server.broadcast_hands
		#client1.capture_output	
		#expect(client1.output).to include "A-S"
	end
end
