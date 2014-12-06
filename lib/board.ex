import Enum
import Dict

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

  def find_empty_cell(board) do
    find_index(board, &(&1 == 0))
  end

  def find_candidates(board, index) do
    (1..9) |>
      reject(&(find_used_numbers_in_row(board, index) |> member?(&1))) |>
      reject(&(find_used_numbers_in_column(board, index) |> member?(&1))) |>
      reject(&(find_used_numbers_in_block(board, index) |> member?(&1)))
  end

  def find_used_numbers_in_row(board, index) do
    start_of_row = index - rem(index, 9)
    board |>
      slice(start_of_row, 9) |>
      filter(&(&1 != 0))
  end

  def find_used_numbers_in_column(board, index) do
    start_of_column = rem(index, 9)
    board |> 
      Enum.drop(start_of_column) |> 
      take_every(9) |>
      filter(&(&1 != 0))
  end

  def find_used_numbers_in_block(board, index) do
    block = @block_indices |> Dict.get(index)
    block |> 
      map(&(board |> Enum.at(&1))) |>
      filter(&(&1 != 0))
  end

  def print_board(board) do
    # TODO there must be a nicer way to write this
    rows = chunk(board, 9)
    each(rows, fn r ->
      each(r, fn c -> 
        IO.write "#{c} "
      end)
      IO.puts ""
    end)
  end
     
end
