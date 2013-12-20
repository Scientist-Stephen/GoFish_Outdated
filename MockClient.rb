require 'socket'
require 'rspec'
require_relative 'FishDeck.rb'
require_relative 'FishHand.rb'
require_relative 'FishGame.rb'
require_relative 'FishServer.rb'


class MockClient

	attr_reader :output, :game, :to_server

	def initialize
		@socket = TCPSocket.new('localhost', 3333)
	end

	def capture_output
		@output = @socket.read_nonblock(1000)
	rescue
		@output = ""
	end

	def output_to_server(output_message)
		@to_server = @socket.puts(output_message)
	end
end