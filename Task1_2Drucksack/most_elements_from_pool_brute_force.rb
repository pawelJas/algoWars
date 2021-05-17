# frozen_string_literal: true

class MostElementsFromPoolBruteForce
  def call(pairs, max_capacity1, max_capacity2, index)
    if index.zero? || (max_capacity1.zero? && max_capacity2.zero?)
      0
    else
      left_weight, right_weight = pairs[index - 1]

      if left_weight <= max_capacity1 && right_weight <= max_capacity2
        [
          1 + call(pairs, max_capacity1 - left_weight, max_capacity2 - right_weight, index - 1),
          call(pairs, max_capacity1, max_capacity2, index - 1)
        ].max
      else
        call(pairs, max_capacity1, max_capacity2, index - 1)
      end
    end
  end
end
