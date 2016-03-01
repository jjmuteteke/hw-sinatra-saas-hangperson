class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(new_word)
    @word = new_word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = ''
    @word.each_char{|c| @word_with_guesses += '-'}
    :win
    :lose
    :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  #getters returns word
  def word
    @word
  end
  
  def guesses
    @guesses
  end
  
  def wrong_guesses
    @wrong_guesses
  end
  
  def word_with_guesses
    @word_with_guesses
  end
  
  def update_wwwg(letter)
    @word.each_char.with_index {|c, index| 
      if c == letter
        @word_with_guesses[index] = letter
      end  
    }
  end
  
  def check_win_or_lose
    if @wrong_guesses.length == 7
      return :lose
    elsif @word_with_guesses == @word
      return :win
    else
      return :play
    end
  end
      
  #takes player guess
  def guess(my_guess)
    if my_guess.to_s.length == 1  && my_guess.to_s =~ /[[:alpha:]]/ 
      my_guess.downcase!
      if @word.include?(my_guess)
        if @guesses.include?(my_guess) 
          return false
          #if wrong_guess lentgh is 7 game over
        else
          @word.each_char{|c|
          if c == my_guess
            @guesses << c
            end            
          }
          update_wwwg(my_guess)
        end
      else
       if @wrong_guesses =~ /#{my_guess}/
        return false
      else
        
        @wrong_guesses << my_guess
      end
      end
    else
      raise ArgumentError.new("invalid guess")
    end
  end
  #guesses several letters
  def guess_several_letters(game,letters)
    letters.each_char{|c| game.guess(c)}
  end

end
