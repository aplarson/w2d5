class Array
  def remove_dups
    result = []
    self.each do |el|
      result << el unless result.include?(el)
    end
    result
  end
  
  def two_sum
    pairs = []
    self.each_index do |first_idx|
      (first_idx + 1...self.length).each do |last_idx|
        pairs << [first_idx, last_idx] if self[first_idx] + self[last_idx] == 0
      end
    end
    pairs
  end
end

class TowersOfHanoi
  attr_accessor :towers
  def initialize
    @towers = [[3, 2, 1], [], []]
  end
  
  def move_disks(origin, dest)
    if !(towers[dest].last.nil?) && towers[origin].last > towers[dest].last
      raise "CANNOT MOVE DISKS HUMAN"
    end
    towers[dest] << towers[origin].pop
  end
  
  def won?
    towers[0] == [] && (towers[1] == [3, 2, 1] || towers[2] == [3, 2, 1])
  end
end

def my_transpose(matrix)
  unless matrix.all? { |row| row.is_a?(Array) } && !matrix.empty?
    raise "That is not a matrix"
  end 
  raise "Not square" if matrix.length != matrix[0].length
  new_matrix = Array.new(matrix.length) {Array.new(matrix.length) {nil}}
  matrix.each_with_index do |row, i|
    row.each_with_index do |col, j|
      new_matrix[j][i] = matrix[i][j] 
    end
  end
  new_matrix
end

def stock_picker(array)
  largest = 0
  result = []
  array.each_index do |idx|
    ((idx + 1)...array.length).each do |stock|
      if (array[stock] - array[idx]) > largest
        largest = array[stock] - array[idx]
        result = [idx, stock]
      end
    end
  end
  result
end