# frozen_string_literal: true

require_relative 'most_elements_from_pool_brute_force'

RSpec.describe MostElementsFromPoolBruteForce do
  describe '#call' do
    subject(:max_elements) do
      described_class.new.call(
        [[0, 1], [0, 3], [1, 0], [1, 1], [2, 0]],
        max_capacity,
        max_capacity,
        5
      )
    end

    context 'for capacity 1' do
      let(:max_capacity) { 1 }

      it { is_expected.to be(2) }
    end

    context 'for capacity 2' do
      let(:max_capacity) { 2 }

      it { is_expected.to be(3) }
    end

    context 'for capacity 3' do
      let(:max_capacity) { 3 }

      it { is_expected.to be(3) }
    end

    context 'for capacity 4' do
      let(:max_capacity) { 4 }

      it { is_expected.to be(4) }
    end
  end
end
