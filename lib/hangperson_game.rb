class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    #@displayed = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    raise ArgumentError unless letter =~ /[A-Za-z]/
    letter.downcase!
  
    @word.include?(letter) ? (@guesses.include?(letter) ? false : @guesses = @guesses + letter) : 
                             (@wrong_guesses.include?(letter) ? false : @wrong_guesses = @wrong_guesses + letter)
    
  end 
  
  def word_with_guesses
    @displayed = ''
    @word.chars do |letter|
      @guesses.include?(letter) ? @displayed = @displayed + letter : @displayed = @displayed + '-'
    end  
      @displayed
  end
  
  def check_win_or_lose
    self.word_with_guesses
    
    if @displayed == @word  
      :win
    elsif  @wrong_guesses.length == 7
      :lose
    else 
      :play
    end
  end  

end
