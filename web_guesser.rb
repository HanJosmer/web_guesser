require 'sinatra'
require 'sinatra/reloader'

# number = rand(101)
set :number, rand(101)

def check_guess guess, number
    if guess.to_i.between?(number + 1, number + 5)
        return 3
    elsif guess.to_i.between?(number - 5, number - 1)
        return 1
    elsif guess.to_i == number
        return 2
    elsif guess.to_i > number + 5
        return 4
    elsif guess.to_i < number - 5
        return 0
    else
        return nil
    end
end

@@guesses = 6

messages = [
    "Way too low!",
    "Too low!",
    "You got it right!!",
    "Too high!",
    "Way too high!"
]

colors = [
    "red",
    "pink",
    "green",
    "pink",
    "red"
]

get '/' do
    guess = params["guess"]
    cheat = params["cheat"]
    accuracy = check_guess(guess, settings.number)
    message = messages[accuracy]
    color = colors[accuracy]
    @@guesses = @@guesses - 1
    
    if @@guesses < 1
        erb :loser
    else
        erb :index, :locals => {:number => settings.number,
                                :message => message,
                                :bg_color => color,
                                :guesses => @@guesses,
                                :cheat_mode => cheat}
    end
end