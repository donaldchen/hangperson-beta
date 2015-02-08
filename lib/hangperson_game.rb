class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  def initialize(new_word)
  	@word = new_word
  	@guesses = ''
  	@wrong_guesses = ''
  end

  attr_accessor(:word, :guesses, :wrong_guesses)

  def guess(letter)
  	raise(ArgumentError, 'guess must not be empty or nil') if letter == '' or letter == nil
  	raise(ArgumentError, 'guess must be a letter') unless letter =~ /[A-Za-z]/ 
  	guess_list = self.wrong_guesses
  	guess_list = self.guesses if /#{letter.downcase}/ =~ self.word
  	return false if /#{letter.downcase}/ =~ guess_list
	guess_list.concat(letter)
  end

  def word_with_guesses
  	result = ''
  	self.word.split('').each do |letter| 
  		/#{letter}/ =~ self.guesses ? result += letter : result += '-'
  	end
  	result
  end

  def check_win_or_lose
  	if self.wrong_guesses.length < 7
  		status = :win
  		self.word.split('').each do |letter|
  			status = :play unless /#{letter}/ =~ self.guesses
  		end
  		return status
  	end
  	return :lose
  end

  # Get a word from remote "random word" service

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
