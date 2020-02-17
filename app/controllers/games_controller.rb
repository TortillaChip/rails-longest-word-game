require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = generate_grid(10)
  end

  def score
    word = params[:word]
    letters = params[:letters].split('')
    time = Time.now.to_i - params[:start_time].to_i
    # raise
    session[:score] = 0 if session[:score].nil?
    if english_word?(word) && check(word, letters)
      session[:score] += (word.length / time.to_f).round(3)
      @result = 'You win!'
      @score = session[:score]
    elsif !english_word?(word) && check(word, letters)
      @score = session[:score]
      @result = 'Your word is not an enlish word, but can be build from the letters'
    elsif english_word?(word) && !check(word, letters)
      @score = session[:score]
      @result = 'Your word is an english word but cannot be build from the given lettes'
    else
      @score = session[:score]
      @result = 'Your word is not english and cannot be build from the given letters. You suck'
    end
  end

  # own methods from old exercise
  def check(string, grid)
    string = string.downcase.split('')
    grid.each do |letter|
      string.delete_at(string.index(letter) || string.length) if string.include?(letter)
    end
    string == []
  end

  def calculate_score(word, time)
    word.length / time.to_f
  end

  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    Array.new(grid_size) { ('a'..'z').to_a.sample }
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    user['found']
  end
end
