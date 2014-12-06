import Enum
import Sudoxir.Board

# The Sudoku solving algorithm
defmodule Sudoxir.Solver do

  def solve(board) do
    # Find the next available empty cell and attempt to fill it
    case find_empty_cell(board) do
      nil ->
        # No empty cells left = we're done
        IO.puts "Found a solution!"
        print_board(board)
        send Sudoxir.Coordinator, {:finished}
      index ->
        # Found an empty cell. Find all numbers that can
        # legally fill that cell, and try them all in parallel
        case find_candidates(board, index) do
          [] ->
            # There's an empty cell, but we can't fill it
            {:giveup}
          list ->
            # Brute-force: try all possible solutions
            try_candidates(board, index, list)
        end
    end
  end

  # Try to solve by inserting all possible legal values into the given index.
  #
  # Each solution is spawned as a separate process, so they run in parallel.
  def try_candidates(board, index, candidates) do
    candidates |>
      each(fn c ->
        new_board = board |> List.replace_at(index, c)
        spawn Sudoxir.Solver, :solve, [new_board]
      end)
  end

end
