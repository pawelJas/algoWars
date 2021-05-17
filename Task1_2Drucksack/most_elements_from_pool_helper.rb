# frozen_string_literal: true
module MostElementsFromPoolHelper
  module_function
  def generate_unbalanced(n)
    pairs = []
    m = 0
    while n >= m
      pairs << [n, m]
      n -= 1
      m += 1
    end
    pairs
  end
  def generate_random(size, max_n, skew = 0)
    total_a = 0
    total_b = 0
    pairs = size.times.map do
      next_a = rand(1..max_n)
      next_b = rand(1..max_n) + rand(0..skew)
      total_a += next_a
      total_b += next_b
      [next_a, next_b]
    end
    [[total_a, total_b].max, pairs]
  end
end
