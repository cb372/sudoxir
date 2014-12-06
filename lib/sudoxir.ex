import Enum
import Sudoxir.Board

defmodule Sudoxir do

  # TODO define board model with helper methods
  # TODO load board from file and parse it
  # if board is full:
  #   tell somebody we have finished
  # else:
  #   find the next empty cell.
  #   if it has at least one valid candidate:
  #     for each candidate for that cell:
  #       create a board with that number filled in
  #       spawn a new process and pass the board to it
  #   else:
  #     we have failed
 
  def main(board_file) do
    {:ok, lines} = File.read board_file
    board = String.split(lines) |> 
      map(&(Integer.parse(&1) |> elem(0)))
    solve(board)
  end

  def solve(board) do
    case find_empty_cell(board) do
      nil -> 
        IO.puts "Found a solution!"
        print_board(board)
        {:solved}
      index ->
        case find_candidates(board, index) do
          [] -> {:giveup}
          list -> try_candidates(board, index, list)
        end
    end
  end

  def try_candidates(board, index, candidates) do
    # TODO this should be done in parallel
    candidates |>
      each(&(solve(board |> List.replace_at(index, &1))))
  end

end

# TODO work out how to build an application and how to use mix
Sudoxir.main("board.txt")
