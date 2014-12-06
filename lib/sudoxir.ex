import Enum

# The entry point to the app
defmodule Sudoxir do

  def main(board_file) do
    # Parse the board file
    {:ok, lines} = File.read board_file
    board = String.split(lines) |> 
      map(&(Integer.parse(&1) |> elem(0)))

    # Start the coordinator
    coord_task = Task.async(Sudoxir.Coordinator, :start, [])

    # Start solving the puzzle
    spawn Sudoxir.Solver, :solve, [board]

    # Stay alive until the coordinator ends
    Task.await(coord_task)
  end

end
