require "./theory"

class Runner
  def initialize
    @results = []
  end

  def run_program
    intro
    loop do
      input = gets.chomp.downcase
      case input
      when 'q'
        break
      when 'i'
        instructions
      when 'h'
        legend
      when 's'
        start_game
      when 'p'
        print_answer_guide
      end
    end
  end

  def intro
    puts "Welcome to Speed_Theory! \n\n"
    puts "s: start, h: Display Legend, i: instructions, q: quit"
  end

  def instructions
    puts "\nYour job is to correctly identify answers to musical interval questions as quickly as possible!"
    puts "\nThe console will ask you interval questions in the following format:"
    puts "\n{interval} {direction} {query_note}?"
    puts "AKA: Major 3rd ABOVE C? (answer: E), Minor 7th BELOW C#? (answer: D#), Perfect 4th above Db? (answer: Gb)"
    puts "\nNotes:\n\nAll input is taken to lowercase format\nEvery correct answer adds 1 to your streak\nWhen you finish, a list of all correct answers will be printed"
    puts "Type 'h' to find out what kinds of input are accepted."
    puts "Good Luck!!"
  end

  def legend
    puts "To respond to each question, type a single string of lowercase letters in which: "
    puts "1) The first letter is the note you think is right (a, b, c, etc)"
    puts "2) The second letter is the accidental you think is right: 'n' for natural, 'w' for flat, and 's' for sharp."
    puts "If no second letter is provided, the algorithm will assume you mean 'natural'."
    puts "All other input will result in an incorrect answer."
  end

  def start_game
    loop do
      theory = Theory.new
      theory.print_instance
      input = gets.chomp.downcase
      if input == "q"
        intro
        break
      end
      if theory.determine_user_accuracy(input)
        @results << theory.record_accurate_guess
      else
        puts "SHUCKS! That was an incorrect answer."
        puts "Your streak was #{@results.length} guesses long!"
        puts "Here are your answers:\n"
        print_answers @results
        @results = []
      end
    end
  end

  def print_answer_guide
    theory_copy = Theory.new
    p theory_copy.generate_answer_guide
  end

  def print_answers results
    results.each { |result| puts "#{result["interval"]} #{result["direction"]} #{result["base_note"]} is #{result["correct_answer"]}" }
    puts "\n\n"
  end
end

runner = Runner.new
runner.run_program
