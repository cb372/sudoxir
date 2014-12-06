# Simple coordinator progress to keep the program from terminating
# until we have found a solution.
#
# Note that the process terminates as soon as we find a solution,
# so we don't need to bother cancelling tasks, etc.
defmodule Sudoxir.Coordinator do

  def start do
    # Register myself with a name so that people can send me messages
    Process.register(self, Sudoxir.Coordinator)

    # Just stay alive until we get a :finished message
    receive do
      {:finished} -> :ok
    end
  end

end
