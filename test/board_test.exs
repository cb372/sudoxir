import Sudoxir.Board

defmodule SudoxirBoardTest do
  use ExUnit.Case

  setup do
    {:ok, [board: [
0, 0, 0, 1, 0, 5, 0, 6, 8,
0, 0, 0, 0, 0, 0, 7, 0, 1,
9, 0, 1, 0, 0, 0, 0, 3, 0,
0, 0, 7, 0, 2, 6, 0, 0, 0,
5, 0, 0, 0, 0, 0, 0, 0, 3,
0, 0, 0, 8, 7, 0, 4, 0, 0,
0, 3, 0, 0, 0, 0, 8, 0, 5,
1, 0, 5, 0, 0, 0, 0, 0, 0,
7, 9, 0, 4, 0, 1, 0, 0, 0
    ]]}
  end

  test "find_empty_cell/1", %{board: board} do
    IO.puts(board)
    assert find_empty_cell(board) == 0
  end

  test "find_candidates/2", %{board: board} do
    assert find_candidates(board, 0) == [2,3,4]
    assert find_candidates(board, 10) == [2,4,5,6,8]
    assert find_candidates(board, 40) == [1,4,9]
    assert find_candidates(board, 80) == [2,6]
  end

  test "find_used_numbers_in_row/2", %{board: board} do
    assert find_used_numbers_in_row(board, 0) == [1,5,6,8]
    assert find_used_numbers_in_row(board, 10) == [7,1]
    assert find_used_numbers_in_row(board, 80) == [7,9,4,1]
  end

  test "find_used_numbers_in_column/2", %{board: board} do
    assert find_used_numbers_in_column(board, 0) == [9,5,1,7]
    assert find_used_numbers_in_column(board, 10) == [3,9]
    assert find_used_numbers_in_column(board, 80) == [8,1,3,5]
  end

  test "find_used_numbers_in_block/2", %{board: board} do
    assert find_used_numbers_in_block(board, 0) == [9,1]
    assert find_used_numbers_in_block(board, 10) == [9,1]
    assert find_used_numbers_in_block(board, 40) == [2,6,8,7]
    assert find_used_numbers_in_block(board, 80) == [8,5]
  end

end
