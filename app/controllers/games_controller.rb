class GamesController < ApplicationController
  def new
    alphabet = ("a".."z").to_a
      grid = []
      (0...10).each do
        grid << alphabet.sample
      end
    @letters = grid
  end

  def score
    require 'open-uri'

    grid = params[:letters].chars
    solution = params[:word].downcase.chars.map { |char| char.downcase }.join

    first_condition = solution.chars.all? { |char| solution.chars.count(char) <= grid.count(char) }

    tmp = open("https://wagon-dictionary.herokuapp.com/#{solution}")
    json_result = JSON.parse(tmp.read)
    second_condition = json_result["found"]


    # @time = (Time.now - Time.new(params[:time])
    @time = (Time.now.strftime('%s').to_i - params[:start_time].to_i)

    @score = json_result["length"].to_i / @time


    if !first_condition
      @message = "The word #{params[:word]} contains characters that are not in the grid"
    elsif !second_condition
      @message = "The word #{params[:word]} is not an english word"
    else
      @message = "Well done!"
    end
  end
end
