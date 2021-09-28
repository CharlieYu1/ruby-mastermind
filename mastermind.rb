NUMBER_OF_COLORS = 6

class MasterMind

    def initialize
        puts "Welcome to Mastermind"
        return new_game
    end

    def new_game
        @secret = generate_new_secret
        @guesses = []
        @round_result_pegs = []
        return play_round
    end

    def play_round
        display_board
        guess = get_input
        round_result = compare_guess(guess)
        return check_end(round_result)
    end

    def check_end(round_result)
        if round_result == "4A0B"
            display_board(game_end=true)
            puts "You win! Press Enter for a new game."
            gets.chomp
            return new_game
        elsif num_guesses == 10
            display_board(game_end=true)
            puts "You lose! Press Enter for a new game."
            gets.chomp
            return new_game
        else
            return play_round
        end
    end

    def compare_guess(guess)
        correct_position_guesses = (0..3).map { |i|
            guess[i] == @secret[i] ? 1 : 0
        }.sum
        correct_any_position_guesses = (1..NUMBER_OF_COLORS).map { |i|
            [guess.count(i.to_s), @secret.count(i.to_s)].min
        }.sum
        a_pegs = correct_position_guesses
        b_pegs = correct_any_position_guesses - correct_position_guesses
        @round_result_pegs << "#{a_pegs}A#{b_pegs}B"
        return "#{a_pegs}A#{b_pegs}B"
    end

    def get_input
        while true
            print "What is your guess? "
            guess = gets.chomp
            if validate_input(guess)
               @guesses << guess
               return guess
            else
                puts "Wrong input. Please try again."
            end
        end
    end

    def validate_input(guess)
        if guess.length != 4
            return false
        end
        (0..3).all? { |i| guess[i].to_i.between?(1, NUMBER_OF_COLORS) }
    end

    def num_guesses
        @guesses.length
    end

    def display_board(game_end=false)
        (0..9).each do |i|
            print "#{(i+1).to_s.rjust(2, ' ')} | "
            if i < @guesses.length
                print "#{@guesses[i]} | #{@round_result_pegs[i]}\n"
            else
                print "**** |\n"    
            end
        end
        puts "----------------"
        print " S | "
        if game_end
            puts "#{@secret} | "
        else
            puts "**** | "
        end
    end

    def generate_new_secret
        (0..3).map { |i|
            rand(1..NUMBER_OF_COLORS).to_s
        }.join()
    end
end

mastermind = MasterMind.new()