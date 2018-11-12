require './lib/connect_four.rb'

puts "Welcome to Connect Four!"
puts "Player 1, what is your name?"
p1 = gets.chomp
puts "Player 2, what is your name?"
p2 = gets.chomp

game = Game.new(p1, p2)
game.play
