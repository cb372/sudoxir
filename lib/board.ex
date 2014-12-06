import Enum
import Dict

# A bunch of helper methods related to the board
defmodule Sudoxir.Board do

  # lookup table for the indices in the 3x3 blocks
  @block_indices [
    [0,1,2,9,10,11,18,19,20],
    [3,4,5,12,13,14,21,22,23],
    [6,7,8,15,16,17,24,25,26],
    [27,28,29,36,37,38,45,46,47],
    [30,31,32,39,40,41,48,49,50],
    [33,34,35,42,43,44,51,52,53],
    [54,55,56,63,64,65,72,73,74],
    [57,58,59,66,67,68,75,76,77],
    [60,61,62,69,70,71,78,79,80]
  ] |> reduce(%{}, fn(b, acc) -> b |> reduce(acc, fn(i, acc2) -> acc2 |> put(i, b) end) end)

  # Find the next empty cell, if any.
  # Returns nil if the board is complete.
  def find_empty_cell(board) do
    find_index(board, &(&1 == 0))
  end

  # Find all numbers which can legally be inserted into
  # the square with the given index
  def find_candidates(board, index) do
    # all numbers ...
    # not already used in the row ...
    # and not already used in the column ...
    # and not already used in the 3x3 block, are valid candidates
    (1..9) |>
      reject(&(find_used_numbers_in_row(board, index) |> member?(&1))) |>
      reject(&(find_used_numbers_in_column(board, index) |> member?(&1))) |>
      reject(&(find_used_numbers_in_block(board, index) |> member?(&1)))
  end

  # Find all numbers that have already been used in this row
  def find_used_numbers_in_row(board, index) do
    start_of_row = index - rem(index, 9)
    board |>
      slice(start_of_row, 9) |>
      filter(&(&1 != 0))
  end

  # Find all numbers that have already been used in this column
  def find_used_numbers_in_column(board, index) do
    start_of_column = rem(index, 9)
    board |> 
      Enum.drop(start_of_column) |> 
      take_every(9) |>
      filter(&(&1 != 0))
  end

  # Find all numbers that have already been used in this 3x3 block
  def find_used_numbers_in_block(board, index) do
    # Note: there's probably a smarter way to do this,
    # but I just hardcoded the lists of indices for each block
    # in a lookup table
    indices = @block_indices |> Dict.get(index)
    values = indices |> map(&(board |> Enum.at(&1)))
    values |> filter(&(&1 != 0))
  end

  # Pretty-print the board to stdout
  def print_board(board) do
    rows = chunk(board, 9)
    rows |> each(fn r ->
      r |> each(fn c -> 
        IO.write "#{c} "
      end)
      IO.puts ""
    end)
  end
     
end
