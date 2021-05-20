# frozen_string_literal: true

require 'benchmark'

require_relative 'most_elements_from_pool'
require_relative 'Pawel_AxBxN.rb'
require_relative 'most_elements_from_pool_helper'



def run_unalanced(n)
  pairs = MostElementsFromPoolHelper.generate_unbalanced(n)
  a = n
  b = n
  alexs = 0
  pawels = 0

  puts "Unbalanced Tests (#{n})"
  Benchmark.bm(7) do |x|
    x.report("Alex: ") {  alexs =  MostElementsFromPool.new(pairs, a, b).max_elements}
    x.report("Pawel: ") { pawels = solve(a, b, pairs) }
    puts "Alex's output: #{alexs}"
    puts "Pawel's output: #{pawels}"
  end
end

def run_random(n)
  pairs = MostElementsFromPoolHelper.generate_random(n, n)[1]
  a = n
  b = n
  alexs = 0
  pawels = 0
  puts "Random Tests (#{n})"
  Benchmark.bm(7) do |x|
    x.report("Alex: ") {  alexs =  MostElementsFromPool.new(pairs, a, b).max_elements}
    x.report("Pawel: ") { pawels = solve(a, b, pairs) }
    puts "Alex's output: #{alexs}"
    puts "Pawel's output: #{pawels}"
  end
end

n = 500
run_random(n)
run_unalanced(n)
