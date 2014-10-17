require 'array_exercises.rb'

describe "remove_dups" do
  it "removes dups" do
    expect([1, 2, 1, 3, 3].remove_dups).to eq([1, 2, 3])
  end
  
  it "works on an empty array" do
    expect([].remove_dups).to eq([])
  end
end

describe "two_sum" do
  it "finds pairs that sum to zero" do
    expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
  end
end

describe "TowersOfHanoi" do
  subject(:game) { TowersOfHanoi.new }
  it "has three towers" do
    expect(game.towers.length).to eq(3)
  end
  it "starts with one tower full" do
    expect(game.towers.first.length).to eq(3)
  end
  it "starts with two towers empty" do
    expect(game.towers[1..2].all?{|tower| tower.empty?}).to be_true
  end
  it "should move disks" do 
    game.move_disks(0, 1)
    expect(game.towers[0]).to eq([3, 2])
    expect(game.towers[1]).to eq([1])
  end
  it "does not put a larger disc on a smaller disc" do
    game.move_disks(0, 1)
    expect { game.move_disks(0, 1) }.to raise_error("CANNOT MOVE DISKS HUMAN")
  end
  it "ends when we have moved all disks to a new tower" do
    game.towers = [[],[3, 2, 1], []]
    expect(game.won?).to be_true
  end
end

describe "transpose" do
  it "converts rows to columns" do
    rows = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
      ]
      cols = [
          [0, 3, 6],
          [1, 4, 7],
          [2, 5, 8]
        ]
      expect(my_transpose(rows)).to eq(cols)
  end
  
  it "does not transpose arrays that are not 2-d" do
    expect { my_transpose([]) }.to raise_error("That is not a matrix")
  end
  
  it "does not transpose non-square matrices" do
    expect { my_transpose([[1, 2, 3], [3, 4, 5]]) }.to raise_error("Not square")
  end

end

describe "stock picker" do
  it "PICKS STOCKS" do
    expect(stock_picker([500, 600, 60, 34, 35, 5000])).to eq([3, 5])
  end
  it "does not pick stock if all losses" do
    expect(stock_picker([10000, 1000, 100, 10])).to eq([])
  end
end