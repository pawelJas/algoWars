# frozen_string_literal: true

class MostElementsFromPool
  attr_reader :pairs, :max_capacity, :b_capacity_bonus, :a_capacity_bonus

  def initialize(pairs, max_capacity_a, max_capacity_b)
    @max_capacity = [max_capacity_a, max_capacity_b].min

    @a_capacity_bonus = max_capacity_a > max_capacity_b ? max_capacity_a - max_capacity_b : 0
    @b_capacity_bonus = max_capacity_b > max_capacity_a ? max_capacity_b - max_capacity_a : 0

    @pairs = pairs.sort_by { |a, b| [(a - b).abs, a + b] }
  end

  def max_elements
    build_table[pairs.count][max_capacity].first
  end

  def build_table
    table = build_empty_table(pairs.count + 1, max_capacity + 1)

    (1..pairs.count).each do |pair_number|
      pair = pairs[pair_number - 1]

      (0..max_capacity).each do |capacity|
        previous = table[pair_number - 1][capacity]
        with_capacity_removed = table[pair_number - 1][capacity - pair.max]

        table[pair_number][capacity] = calculate_entry(pair, previous, with_capacity_removed, capacity)
      end
    end

    table
  end

  def calculate_entry(pair, previous, with_capacity_removed, capacity)
    previous_incrementable = fill_pairs_with_sufficient_capacity(pair, previous[1], capacity)

    if previous_incrementable.empty?
      calculate_from_capacity_removed(pair, previous, with_capacity_removed, capacity)
    elsif with_capacity_removed && with_capacity_removed[0] == previous[0]
      extra_pairs = fill_pairs_with_sufficient_capacity(pair, with_capacity_removed[1], capacity)

      [previous[0] + 1, keep_best_pairs(extra_pairs + previous_incrementable)]
    else
      [previous[0] + 1, previous_incrementable]
    end
  end

  def calculate_from_capacity_removed(pair, previous, with_capacity_removed, capacity)
    return previous if with_capacity_removed.nil? || with_capacity_removed[0] < previous[0] - 1

    extra_pairs = fill_pairs_with_sufficient_capacity(pair, with_capacity_removed[1], capacity)

    return previous if extra_pairs.empty?

    case with_capacity_removed[0] - previous[0]
    when 0 then [previous[0] + 1, extra_pairs]
    when -1 then [previous[0], keep_best_pairs(previous[1] + extra_pairs)]
    else previous
    end
  end

  def keep_best_pairs(pairs)
    pairs.sort!
    compare_pair = pairs.first
    deduped_pairs = [pairs.first]

    (1..pairs.count - 1).each do |i|
      next if compare_pair[0] <= pairs[i][0] && compare_pair[1] <= pairs[i][1]

      compare_pair = pairs[i]
      deduped_pairs << pairs[i]
    end

    deduped_pairs
  end

  def fill_pairs_with_sufficient_capacity(pair, existing_pairs, capacity)
    a_capacity = capacity + a_capacity_bonus
    b_capacity = capacity + b_capacity_bonus

    existing_pairs.each_with_object([]) do |(l, r), pairs|
      next unless l + pair[0] <= a_capacity && r + pair[1] <= b_capacity

      pairs << [l + pair[0], r + pair[1]]
    end
  end

  def build_empty_table(rows, columns)
    empty_entry = [0, [[0, 0]]]
    rows.times.map { columns.times.map { empty_entry } }
  end
end
