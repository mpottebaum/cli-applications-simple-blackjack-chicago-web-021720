require 'pry'

row_0 = [{:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}]
row_1 = [{:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}]
row_2 = [{:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}]
row_3 = [{:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}]
row_4 = [{:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}]
row_5 = [{:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}]
row_6 = [{:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}, {:value => 0, :selected => false}]

grid = [row_0, row_1, row_2, row_3, row_4, row_5, row_6]

def display_row(row, row_number)
  row_display = "#{row_number}"
  row.each do |space|
    row_display += "  "
    if space[:selected] == false
      row_display += "X"
    elsif space[:value] == 0 && space[:selected] == true
      row_display += "O"
    elsif space[:value] == 1 && space[:selected] == true
      row_display += "!"
    else
      row_display += "8"
    end
  end
  puts row_display
end

def display_column_headings
  column_coordinates = ["1", "2", "3", "4", "5", "6", "7"]
  column_display = " "
  column_coordinates.each {|heading| column_display += "  #{heading}"}
  puts column_display
end

def display_grid(grid)
  row_coordinates = ["A", "B", "C", "D", "E", "F", "G"]
  display_column_headings
  grid.each_with_index do |row, row_index|
    display_row(row, row_coordinates[row_index])
  end
end

def mark_win_spot(grid, win_row, win_column)
  grid[win_row][win_column][:value] = 2
end

def establish_win_spot(grid)
  win_column = rand(7)
  win_row = rand(7)
  mark_win_spot(grid, win_row, win_column)
  #if win_column == 6
  #  second_win_column = win_column - 1
  #  mark_win_spot(grid, win_row, second_win_column)
  #else
  #  second_win_column = win_column + 1
  #  mark_win_spot(grid, win_row, second_win_column)
  #end
  if win_row == 6
    second_win_row = win_row - 1
    mark_win_spot(grid, second_win_row, win_column)
  else
    second_win_row = win_row + 1
    mark_win_spot(grid, second_win_row, win_column)
  end
end

def establish_mines(grid)
  9.times do
    mine_column = rand(7)
    mine_row = rand(7)
    while grid[mine_column][mine_row][:value] == 2 || grid[mine_column][mine_row][:value] == 1 do
      mine_column = rand(7)
      mine_row = rand(7)
    end
    grid[mine_column][mine_row][:value] = 1
  end
end

def setup_board(grid)
  establish_win_spot(grid)
  establish_mines(grid)
end

#def grid_test(grid)
#  grid.each do |row|
#    row.each {|col| col[:selected] = true}
#  end
#  setup_board(grid)
#  display_grid(grid)
#end

def change_input_to_row_index(row_let)
  ["A", "B", "C", "D", "E", "F", "G"].index(row_let)
end

def change_input_to_col_index(col_numb)
  col_numb.to_i - 1
end


def mark_as_selected(grid, row_index, column_index)
  grid[row_index][column_index][:selected] = true
end

def check_for_ends_and_remove(index_array)
  seven_index = index_array.index(7)
  negative_index = index_array.index(-1)
  if seven_index
    index_array.slice!(seven_index)
  end
  if negative_index
    index_array.slice!(negative_index)
  end
end

def search_and_mark_surrounding(grid, row_index, column_index)
  row_splatters = [(row_index - 1), row_index, (row_index + 1)]
  col_splatters = [(column_index - 1), column_index, (column_index + 1)]
  check_for_ends_and_remove(row_splatters)
  check_for_ends_and_remove(col_splatters)
  row_splatters.each do |row_splatter_index|
    col_splatters.each do |col_splatter_index|
      if grid[row_splatter_index][col_splatter_index][:value] == 1 || grid[row_splatter_index][col_splatter_index][:value] == 2
      else
        grid[row_splatter_index][col_splatter_index][:selected] = true
      end
    end
  end
end

def mark_selected_and_surrounding(grid, row_index, column_index)
  mark_as_selected(grid, row_index, column_index)
  search_and_mark_surrounding(grid, row_index, column_index)
end

def user_turn(grid)
  puts "ENTER A ROW LETTER"
  row_let = gets.strip
  puts "ENTER A COLUMN NUMBER"
  col_numb = gets.strip
  row_index = change_input_to_row_index(row_let)
  column_index = change_input_to_col_index(col_numb)
  mark_selected_and_surrounding(grid, row_index, column_index)
end


def introduction
  puts "TRY TO FIND THE EIGHTS"
  puts "WATCH OUT FOR MINES"
  gets
end

def check_for_win_in_row(row)
  row.any? {|space| space[:value] == 2 && space[:selected] == true}
end

def check_for_win(grid)
  grid.any? {|row| check_for_win_in_row(row) == true}
end

def check_for_loss_in_row(row)
  row.any? {|space| space[:value] == 1 && space[:selected] == true}
end

def check_for_loss(grid)
  grid.any? {|row| check_for_loss_in_row(row) == true}
end

def runner(grid)
  introduction
  updated_grid = grid
  setup_board(updated_grid)
  win_ = check_for_win(updated_grid)
  loss_ = check_for_loss(updated_grid)
  while win_ == false && loss_ == false do
    display_grid(updated_grid)
    user_turn(grid)
    win_ = check_for_win(updated_grid)
    loss_ = check_for_loss(updated_grid)
  end
end

runner(grid)