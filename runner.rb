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
        # legend
        break
      when 's'
        start_game
      when 'p'
        print_answer_guide
      end
    end
  end

  def intro
    puts "Welcome to Speed_Theory! \n\n"
    puts "s: start, p: print answer guide, h: Display Legend, i: instructions, q: quit"
  end

  def instructions
    puts "\nYour job is to correctly identify answers to musical interval questions as quickly as possible!"
    puts "\nThe console will ask you interval questions in the following format:"
    puts "\n{interval} {direction} {query_note}?"
    puts "AKA: Major 3rd ABOVE C? (answer: E), Minor 7th BELOW C#? (answer: D#), Perfect 4th above Db? (answer: Gb)"
    puts "\nNotes:\n\nAll input is taken to lowercase format\nEvery correct answer adds 1 to your streak\nWhen you finish, a list of all correct answers will be printed"
    puts "Good Luck!!"
  end

  def start_game
    loop do
      theory = Theory.new
      theory.print_instance
      input = gets.chomp.downcase
      if input == "q"
        break
      end
      truth = theory.determine_user_accuracy(input)
      if truth
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
