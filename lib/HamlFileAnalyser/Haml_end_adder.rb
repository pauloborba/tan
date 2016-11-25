#adds end to each needed loop, if, etc according to it's indentation
class Haml_end_adder


  def initialize(array)
    $lines_array = []
    $lines_that_needs_end = []
    $end_indentation_values = []
  end

  def add_ends(file_path)
    fill_array(file_path)
    has_need_for_end = /(?=( do| if| begin| case| unless))/
    mid_block_keywords = /(?=( else| elsif| rescue| ensure| end| when))/
    File.foreach(file_path).with_index do |line, line_num|
      if has_need_for_end.match line
        end_was_taken_care = false
        indentation_value = check_indentation_value(line)
        next_indentations_values = look_into_next_lines($lines_array,line_num)
        array_index = 1
        next_indentations_values.each do |next_indentation_value|
          actual_line = line_num + array_index
          has_mid_block = mid_block_keywords.match($lines_array[actual_line])
          line_break = '
'
          if $lines_array[actual_line] != line_break
            if next_indentation_value <= indentation_value && !has_mid_block
              $end_indentation_values.push(indentation_value)
              $lines_that_needs_end.push(actual_line)
              end_was_taken_care = true
              break
            end
          end
          array_index += 1
        end
        if !end_was_taken_care
          $end_indentation_values.push(indentation_value)
          $lines_that_needs_end.push($lines_array.size)
        end
      end
    end
    put_end_on_lines($lines_that_needs_end, $end_indentation_values)
    puts $lines_array.join("\n")
  end

  def put_end_on_lines(lines_number, indentation_values)
    helper_array = $lines_array
    number_of_ends_inserted = 0
    array_index = 0
    lines_number = correct_ends_positioning(lines_number)
    lines_number.each do |line_number|
      indented_end = write_indented_end(indentation_values[array_index])
      actual_line_number = line_number + number_of_ends_inserted
      helper_array.insert(actual_line_number,indented_end)
      array_index += 1
    end
    $lines_array = helper_array
  end

  def correct_ends_positioning(lines_number)
    array_index = 0
    lines_number.each do |line_number|
      if array_index != 0
        lesser_than_line_value = lines_number.size.times.with_object([]) { |i,b| b << i if lines_number[i] < line_number }
        lines_number[array_index] = line_number + lesser_than_line_value.length
      end
      array_index += 1
    end
    lines_number
  end

  def write_indented_end(indentation_value)
    response = '- end'
    while indentation_value != 0
      response = ' ' + response
      indentation_value -= 1
    end
    response
  end

  def look_into_next_lines(lines_array, line_num)
    next_lines_indentation_values = []
    array_index = 0
    iteration  = 0
    lines_array.each do |line|
      if iteration > line_num
        next_lines_indentation_values[array_index] = check_indentation_value(line)
        array_index += 1
      end
      iteration += 1
    end
    next_lines_indentation_values
  end

  def fill_array(file_path)
    File.foreach(file_path).with_index do |line, line_num|
      $lines_array[line_num] = line
      $lines_array
    end
  end

  def check_indentation_value(line)
    indentation = 0
    line.each_char { |char|
      if char != ' '
        break
      else
        indentation = indentation + 1
      end
    }
    indentation
  end
end