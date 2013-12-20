require_relative 'FishDeck.rb'
require_relative 'FishHand.rb'
require_relative 'FishGame.rb'

class GoFishSocketServer

	attr_accessor :clients, :game

	def initialize
		@game = FishGame.new
		@socket_server = TCPServer.new(3333)	#Don't have something holding onto it, it may get garbage collected
		@clients = []
	end

	def accept_client
		@clients << @socket_server.accept	
	end

	def broadcast_hand
		@clients.each_with_index do |client, index|
			client.puts(@game.hands[index].to_s)
		end
	end

	def accept_input_from(client_index)

		@socket_server.clients[client_index].gets 
		#@clients.gets[client_index].gets #blocks waiting for input from client socket
	end

	def close
	#	puts "CLOSING SHOP"
			@socket_server.close
	#	puts "SHOULD BE CLOSED"
	end

	def provide_input(string)	#The hay does this do
		@socket.puts(string)
	end

end

