class Board

  def initialize(size)
    @grid = Array.new(size) {Array.new(size, "_")}
  end

  def display
    system "clear"
    # print out the board
    (0...@grid.length).each do |row|
      (0...@grid.length).each do |col|
        print "#{@grid[row][col]} "
      end
      puts
    end
    nil
  end

  def valid_pos?(pos)
    pos.all?{|ele| ele.between?(0,@grid.length-1) } && pos.length == 2
  end

  def [](pos)
    # get position
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    # change value at position
    x, y = pos
    @grid[x][y] = value
  end

  def empty?(pos)
    x, y = pos
    @grid[x][y] == "_"
  end

  def check_rows
    (0...@grid.length).each do |row|
      return true if @grid[row][0] != "_" && @grid[row].uniq.size <= 1 
    end
    return false
  end

  def check_columns
    grid_dup = @grid.transpose
    (0...grid_dup.length).each do |row|
      return true if grid_dup[row][0] != "_" && grid_dup[row].uniq.size <= 1
    end
    return false
  end

  def check_diagonal
    negative_diagonal = []
    positive_diagonal = []

    (0...@grid.length).each do |idx|
      negative_diagonal << @grid[idx][idx] if @grid[idx][idx] != "_"
      positive_diagonal << @grid[idx][@grid.length-1 - idx] if @grid[idx][@grid.length-1 - idx] != "_"
    end

    neg_diag_win = negative_diagonal.length == @grid.length && negative_diagonal.uniq.size <= 1
    pos_diag_win = positive_diagonal.length == @grid.length && positive_diagonal.uniq.size <= 1

    return neg_diag_win || pos_diag_win

  end

  def won?
    check_rows || check_columns || check_diagonal
  end

  def full?
    @grid.each do |row|
      return false if row.any?{|ele| ele == "_"}
    end

    return true
  end

  def tied?
    !won? && full?
  end



end