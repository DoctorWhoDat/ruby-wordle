require 'pry'
require_relative 'words.rb'


class Main
  def initialize
    correct_sym = '!'
    wrong_spot  = '?'

    word  = Words.new.get_word
    cnt   = 0

    past = []

    puts "Guess #{cnt+1} of 6\nEnter a 5 letter word:"

    while cnt < 6
      field = '*****'
      guess = gets.chomp.downcase
      past << guess

      if word == guess
        puts 'You got it right! Here were your guesses:'
        puts past
        return

      elsif word.count(guess) > 0
        word.split('').map do |l|
          guess =~ /#{l}/
        end.yield_self do |x|
          x.compact.each do |index|
            field[index] = word[index] == guess[index] ? correct_sym : wrong_spot
          end
        end

        puts "#{guess}: #{field}"
      else
        puts 'No Match'
      end

      cnt += 1
    end

    puts past
    puts "Word was: #{word}" unless past[-1] == word
  end
end

Main.new
