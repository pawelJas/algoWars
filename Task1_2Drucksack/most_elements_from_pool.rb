# frozen_string_literal: true

class MostElementsFromPool
  attr_reader :pairs, :max_capacity, :b_capacity_bonus, :a_capacity_bonus

  def initialize(pairs, max_capacity_a, max_capacity_b)
    @max_capacity = [max_capacity_a, max_capacity_b].min

    @a_capacity_bonus = max_capacity_a > max_capacity_b ? max_capacity_a - max_capacity_b : 0
    @b_capacity_bonus = max_capacity_b > max_capacity_a ? max_capacity_b - max_capacity_a : 0

    @pairs = pairs.sort_by { |a, b| [a + b, (a - b).abs] }
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
        without_a_cap = table[pair_number - 1][capacity - pair[0]] unless (capacity - pair[0]).negative?
        without_b_cap = table[pair_number - 1][capacity - pair[1]] unless (capacity - pair[1]).negative?

        table[pair_number][capacity] = calculate_entry(pair, previous, without_a_cap, without_b_cap, capacity)
      end
    end

    table
  end

  def calculate_entry(pair, previous, without_a_capacity, without_b_capacity, capacity)
    candidate_entries = [increment_entry(previous, pair, capacity)]

    [without_b_capacity, without_a_capacity].each do |entry|
      next unless should_explore?(entry, previous, candidate_entries)

      entry = increment_entry(entry, pair, capacity)

      case entry[0] - candidate_entries[0][0]
      when 1 then candidate_entries = [entry]
      when 0 then candidate_entries << entry
      end
    end

    if candidate_entries.count == 1
      candidate_entries.first
    else
      [candidate_entries[0][0], keep_best_pairs(candidate_entries.flat_map { |e| e[1] })]
    end
  end

  def should_explore?(entry, previous, other_candidates)
    entry && entry != previous && entry[0] + 1 >= other_candidates[0][0]
  end

  def keep_best_pairs(pairs)
    pairs.sort!
    compare_pair = pairs.first
    deduped_pairs = [compare_pair]

    (1..pairs.count - 1).each do |i|
      next if compare_pair[0] <= pairs[i][0] && compare_pair[1] <= pairs[i][1]

      compare_pair = pairs[i]
      deduped_pairs << pairs[i]
    end

    deduped_pairs
  end

  # Either returns the entry with new pairs and an incremented element count,
  # or if none can be incremented, the original entry
  def increment_entry(entry, pair, capacity)
    a_capacity = capacity + a_capacity_bonus
    b_capacity = capacity + b_capacity_bonus

    new_pairs = entry[1].each_with_object([]) do |(l, r), pairs|
      next unless l + pair[0] <= a_capacity && r + pair[1] <= b_capacity

      pairs << [l + pair[0], r + pair[1]]
    end

    new_pairs.empty? ? entry : [entry[0] + 1, new_pairs]
  end

  def build_empty_table(rows, columns)
    empty_entry = [0, [[0, 0]]]
    rows.times.map { columns.times.map { empty_entry } }
  end
end
