require 'sinatra'
require 'sinatra/reloader'

# number = rand(101)
set :number, rand(101)

def check_guess guess, number
    if guess.to_i.between?(number + 1, number + 5)
        return "Too high!"
    elsif guess.to_i.between?(number - 5, number - 1)
        return "Too low!"
    elsif guess.to_i == number
        return "You got it right!!"
    elsif guess.to_i > number + 5
        return "Way too high!"
    elsif guess.to_i < number - 5
        return "Way too low!"
    else
        return ""
    end
end

get '/' do
    guess = params["guess"]
    message = check_guess(guess, settings.number)
    
    erb :index, :locals => {:number => settings.number, :message => message}
end