# frozen_string_literal: true

require 'pry'
require_relative 'most_elements_from_pool'
require_relative 'Pawel_AxBxN'
require_relative 'most_elements_from_pool_helper'
require_relative 'most_elements_from_pool_brute_force'

RSpec.describe MostElementsFromPool do
  context 'for a simple example' do
    let(:pairs) do
      [[0, 1], [1, 0], [1, 1]]
    end

    describe '#build_table' do
      it 'works' do
        expect(described_class.new(pairs, 3, 3).build_table).to eq(
          [
            [[0, [[0, 0]]], [0, [[0, 0]]], [0, [[0, 0]]], [0, [[0, 0]]]],
            [[0, [[0, 0]]], [1, [[0, 1]]], [1, [[0, 1]]], [1, [[0, 1]]]],
            [[0, [[0, 0]]], [2, [[1, 1]]], [2, [[1, 1]]], [2, [[1, 1]]]],
            [[0, [[0, 0]]], [2, [[1, 1]]], [3, [[2, 2]]], [3, [[2, 2]]]]
          ]
        )
      end
    end

    describe '#max_elements' do
      it 'works' do
        expect(described_class.new(pairs, 1, 1).max_elements).to be(2)
        expect(described_class.new(pairs, 2, 2).max_elements).to be(3)
      end
    end
  end

  context 'for a slightly more interesting example' do
    let(:pairs) do
      [[0, 1], [0, 3], [1, 0], [1, 1], [2, 0]]
    end

    describe '#build_table' do
      let(:expected_table) do
        [
          [[0, [[0, 0]]], [0, [[0, 0]]], [0, [[0, 0]]], [0, [[0, 0]]],         [0, [[0, 0]]], [0, [[0, 0]]]],
          [[0, [[0, 0]]], [1, [[0, 1]]], [1, [[0, 1]]], [1, [[0, 1]]],         [1, [[0, 1]]], [1, [[0, 1]]]],
          [[0, [[0, 0]]], [2, [[1, 1]]], [2, [[1, 1]]], [2, [[1, 1]]],         [2, [[1, 1]]], [2, [[1, 1]]]],
          [[0, [[0, 0]]], [2, [[1, 1]]], [3, [[2, 2]]], [3, [[2, 2]]],         [3, [[2, 2]]], [3, [[2, 2]]]],
          [[0, [[0, 0]]], [2, [[1, 1]]], [3, [[2, 2]]], [3, [[2, 2], [3, 1]]], [4, [[4, 2]]], [4, [[4, 2]]]],
          [[0, [[0, 0]]], [2, [[1, 1]]], [3, [[2, 2]]], [3, [[2, 2], [3, 1]]], [4, [[4, 2]]], [5, [[4, 5]]]]
        ]
      end

      it 'works' do
        expect(described_class.new(pairs, 5, 5).build_table).to eq(expected_table)
      end
    end

    describe '#max_elements' do
      it 'works' do
        expect(described_class.new(pairs, 1, 1).max_elements).to be(2)
        expect(described_class.new(pairs, 2, 2).max_elements).to be(3)
        expect(described_class.new(pairs, 3, 3).max_elements).to be(3)
        expect(described_class.new(pairs, 4, 4).max_elements).to be(4)
        expect(described_class.new(pairs, 5, 5).max_elements).to be(5)
      end
    end

    context' when the capacity is different for A and B' do
      describe '#max_elements' do
        it 'works when B is handicapped' do
          expect(described_class.new(pairs, 1, 0).max_elements).to be(1)
          expect(described_class.new(pairs, 2, 1).max_elements).to be(2)
          expect(described_class.new(pairs, 3, 1).max_elements).to be(3)
          expect(described_class.new(pairs, 4, 2).max_elements).to be(4)
          expect(described_class.new(pairs, 5, 3).max_elements).to be(4)
        end

        it 'works when A is handicapped' do
          expect(described_class.new(pairs, 0, 1).max_elements).to be(1)
          expect(described_class.new(pairs, 1, 2).max_elements).to be(2)
          expect(described_class.new(pairs, 1, 3).max_elements).to be(2)
          expect(described_class.new(pairs, 2, 4).max_elements).to be(3)
          expect(described_class.new(pairs, 3, 5).max_elements).to be(4)
        end
      end
    end
  end

  context 'for a very interesting example' do
    let(:pairs) { [[4, 1], [1, 4], [9, 0], [0, 9], [2, 2]] }

    describe '#max_elements' do
      it 'works' do
        expect(described_class.new(pairs, 1, 1).max_elements).to be(0)
        expect(described_class.new(pairs, 3, 3).max_elements).to be(1)
        expect(described_class.new(pairs, 4, 4).max_elements).to be(1)
        expect(described_class.new(pairs, 5, 5).max_elements).to be(2)
        expect(described_class.new(pairs, 7, 7).max_elements).to be(3)
        expect(described_class.new(pairs, 13, 13).max_elements).to be(3)
        expect(described_class.new(pairs, 14, 14).max_elements).to be(4)
        expect(described_class.new(pairs, 15, 15).max_elements).to be(4)
        expect(described_class.new(pairs, 16, 16).max_elements).to be(5)
      end
    end
  end

  context 'for some edge cases' do
    context 'when multiple later pairs sum to equal an earlier pair' do
      let(:pairs) do
        [[0, 3], [3, 0], [0, 3], [3, 0], [0, 2], [0, 1]]
      end

      it 'works out the best answers' do
        expect(described_class.new(pairs, 1, 1).max_elements).to be(1)
        expect(described_class.new(pairs, 2, 2).max_elements).to be(1)
        expect(described_class.new(pairs, 3, 3).max_elements).to be(3)
        expect(described_class.new(pairs, 5, 5).max_elements).to be(3)
        expect(described_class.new(pairs, 6, 6).max_elements).to be(5)
      end
    end

    context 'when multiple later pairs could replace earlier ones' do
      let(:pairs) do
        [[1, 1], [2, 2], [3, 3], [4, 4], [3, 4], [5, 4], [4, 2], [4, 2], [2, 4], [3, 5], [1, 4], [4, 1]]
      end

      it 'works out the best answers' do
        expect(described_class.new(pairs, 14, 14).max_elements).to be(6)
      end
    end
  end

  context 'comparing it to the brute force solution' do
    [
      [5, 10, 0],
      [5, 100, 10],
      [5, 1000, 100],
      [10, 10, 0],
      [10, 100, 10],
      [10, 1000, 100],
      [15, 10, 0],
      [15, 100, 10],
      [15, 1000, 100],
      [20, 10, 0],
      [20, 100, 10],
      [20, 1000, 100]
    ].each do |number_of_pairs, max_value, skew|
      context "with # of pairs #{number_of_pairs}, max value: #{max_value}, skew: #{skew}" do
        let(:max_capacity_and_pairs) do
          MostElementsFromPoolHelper.generate_random(number_of_pairs, max_value, skew)
        end
        let(:pairs) { max_capacity_and_pairs[1] }
        let(:max_capacity) { max_capacity_and_pairs[0] }
        let(:max_capacity_a) { rand(0..max_capacity) }
        let(:max_capacity_b) { rand(0..max_capacity) }

        let(:brute_force_answer) do
          MostElementsFromPoolBruteForce.new.call(pairs, max_capacity_a, max_capacity_b, pairs.count)
        end
        let(:most_elements_from_pool_answer) do
          described_class.new(pairs, max_capacity_a, max_capacity_b).max_elements
        end
        let(:matches?) do
          brute_force_answer == most_elements_from_pool_answer
        end

        it 'gets the same answer as the brute force solution' do
          unless matches?
            puts "Brute force answer: #{brute_force_answer}"
            puts "Described class answer: #{most_elements_from_pool_answer}"
            puts "Max capacity a: #{max_capacity_a}; max capacity b: #{max_capacity_b}."\
                 "\nPairs for investigation: #{pairs}"
          end

          expect(most_elements_from_pool_answer).to eq brute_force_answer
        end
      end
    end
  end
end
