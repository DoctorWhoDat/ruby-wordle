require 'pry'
require_relative 'words.rb'


class Main
  def initialize
    correct_sym = '!'
    wrong_spot  = '?'

    word  = Words.new.get_word
    cnt   = 1

    guesses = []
    fields  = []

    while cnt <= 6
      field = '*****'

      puts "Guess #{cnt} of 6\nEnter a 5 letter word:"
      guess = gets.chomp.downcase
      guesses << guess

      if word == guess
        fields << '!!!!!'
        puts "You got it right in #{cnt} guesses:"
        puts printout(guesses, fields)
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

      fields << field
      cnt += 1
    end

    puts printout(guesses, fields)
    puts "Word was: #{word}" unless guesses[-1] == word
  end

  def printout(g,f)
    g.each_with_index.map do |x,i|
      "#{x}: #{f[i]}" unless f[i].nil?
    end
  end
end

Main.new
