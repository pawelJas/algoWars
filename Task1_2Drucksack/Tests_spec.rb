# frozen_string_literal: true


require_relative 'Pawel_AxBxN.rb'

RSpec.describe "Something You Want To Test" do
  let(:a) {5}
  let(:b) {5}
  let(:input1) {[[0, 1], [2, 1], [1, 1], [1, 3]]}
  let(:input2) {[[1, 1], [2, 1], [1, 1], [1, 2]]}
  let(:input3) {[[3, 1], [3, 1], [3, 1], [3, 2]]}
  let(:input4) {[[0, 1], [0, 1], [0, 1], [0, 2]]}

  describe '.LearningRspec' do
    it 'test of test' do
     expect(2).to eq(2)
    end
  end


  describe '.maxItems' do
    it 'small test for MaxItems' do
      expect(solve(a, b, input1)).to eq(3)
      expect(solve(a, b, input2)).to eq(4)
      expect(solve(2, b, input3)).to eq(0)
      expect(solve(12, 3, input3)).to eq(3)
      expect(solve(2, b, input4)).to eq(4)
    end
  end
end
