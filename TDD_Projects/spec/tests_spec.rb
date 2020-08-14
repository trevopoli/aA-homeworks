require 'tests'
require 'rspec'

describe '#my_uniq' do
    let(:array) {[1,2,1,3,3]}

    it 'should return unique elements in order' do
        expect(my_uniq(array)).to eq([1,2,3])
    end

end


describe Array do

    describe '#two_sum' do
        let(:array) {[-1,0,2,-2,1]}

        it 'should return pairs of positions whose elements sum to zero' do
            expect(array.two_sum).to eq([[0,4], [2,3]])
        end
    end

end

describe '#my_transpose' do
    let (:matrix) {[
        [0,1,2],
        [3,4,5],
        [6,7,8]
    ]}
    let(:rectangular_matrix) {[
        [1,2],
        [3,4,5]
    ]}

    it 'should return a transposed 2D Array' do
        expect(my_transpose(matrix)).to eq([[0,3,6],[1,4,7],[2,5,8]])
    end

    it 'should raise an error if given a non-square matrix' do
        expect {my_transpose(rectangular_matrix)}.to raise_error(ArgumentError)
    end
end

describe '#stock_picker' do
    let(:stocks) {[12,15,17,10,11,12,15,9,12,11,9,7,11,13]}

    it 'should return an array of two days (as indicies) of most profit' do
        expect(stock_picker(stocks)).to eq([11,13])
    end

end

describe TowersOfHanoi do
    subject(:game) {TowersOfHanoi.new}

    describe '#initialize' do
        it 'should set 3 initial arrays right, left, middle and accessors' do
            expect(game.left).to be_an_instance_of(Array)
            expect(game.right).to be_an_instance_of(Array)
            expect(game.middle).to be_an_instance_of(Array)
        end

        it 'should start all 5 blocks to left array' do
            expect(game.left).to eq([1,2,3,4,5])
        end
    end

    describe '#move' do
        it 'should raise error if moving to a tower with smaller piece on top' do
            game.move(1,2)
            expect {game.move(1,2)}.to raise_error('not a valid move')
        end

        it 'should place block at front of new array' do
            game.move(1,3)
            game.move(1,2)
            game.move(3,1)
            expect(game.left[0]).to eq(1)
        end

        it 'should remove block at original array' do
            game.move(1,2)
            expect(game.left[0]).to eq(2)
        end
    end

    describe '#won?' do
        it 'returns true when all stacked on right array' do
            ##set up winning game
            expect(game.won?).to be_true
        end
    end

end