class Theory
  attr_reader :interval_query, :direction, :query_note, :correct_answers

  def initialize
    @all_intervals = ["U", "m2", "M2", "m3", "M3", "P4", "TT", "P5", "m6", "M6", "m7", "M7", "P8", "m9", "M9", "m10", "M10", "P11", "TT", "P12", "m13", "M13", "m14", "M14"] #later, add ["+4", "TT", "d5"] for greater skill level w/ TTs
    @potential_answers = [
      ["an"], ["as", "bw"],
      ["bn", "cw"], ["bs", "cn"],
      ["cs", "dw"], ["dn"],
      ["ds", "ew"], ["en", "fw"],
      ["es", "fn"], ["fs", "gw"],
      ["gn"], ["gs", "aw"]
    ]
    @tone_wheel =
      [
        ["A"], ["A#", "Bb"],
        ["B", "Cb"], ["B#", "C"],
        ["C#", "Db"], ["D"],
        ["D#", "Eb"], ["E", "Fb"],
        ["E#", "F"], ["F#", "Gb"],
        ["G"], ["G#", "Ab"]
      ]
    @display_note_idx = rand(0 .. 11).to_i
    @enharmonic_idx = (@tone_wheel[@display_note_idx].length > 1) ? rand(0..1).to_i : 0
    @display_note = @tone_wheel[@display_note_idx][@enharmonic_idx]
    @note_conversion = @potential_answers[@display_note_idx][@enharmonic_idx]

    @interval_query_idx = rand(@all_intervals.length)
    @interval_query = @all_intervals[@interval_query_idx]
    @direction = (rand >= 0.5) ? "above" : "below"
    @correct_answers = translate(@interval_query, @direction, @note_conversion)
  end

  def print_instance
    puts "#{@interval_query} #{@direction} #{@display_note}"
  end

  def determine_user_accuracy guess
    return false if guess.length > 2 || guess.length == 0
    guess += "n" if guess.length == 1
    return @correct_answers.include?(guess)
  end

  def translate interval, direction, base_note
    directional_array = (direction == "below") ? @potential_answers.reverse : @potential_answers
    spin_instance = spin_tone_wheel(directional_array, base_note)
    wheel = spin_instance["array"]
    step_idx = @all_intervals.index(interval)
    wheel[step_idx]
  end

  def spin_tone_wheel array, search_item
    break_counter = 0
    until array.first.include?(search_item) || break_counter == 13
      array = array.rotate
      break_counter += 1
    end
    array.length.times { |i| array.push(array[i]) }
    { "array" => array, "spin_count" => break_counter }
  end

  def record_accurate_guess
    { "interval" => @interval_query, "direction" => @direction, "base_note" => @query_note, "correct_answer" => translate(@interval_query, @direction, @query_note) }
  end
end
