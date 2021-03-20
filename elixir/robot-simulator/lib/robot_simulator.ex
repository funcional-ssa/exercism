defmodule RobotSimulator do
  @directions [:north, :east, :west, :south]
  @instructions ['A', 'R', 'L']
  @movement %{north: {0, 1}, south: {0, -1}, east: {1, 0}, west: {-1, 0}}
  @left %{north: :west, south: :east, east: :north, west: :south}
  @right %{north: :east, south: :west, east: :south, west: :north}
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction, _) when direction not in @directions, do: {:error, "invalid direction"}

  def create(_, {x, y} = position) when not is_integer(x) and not is_integer(y),
    do: {:error, "invalid position"}

  def create(direction \\ :north, {x, y} = position \\ {0, 0})
      when is_integer(x) and is_integer(y) do
    %{direction: direction, position: position}
  end

  def create(_, _), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    # cond do
    #   instructions
    #   |> String.to_charlist()
    #   |> Enum.all?(fn x -> x in @instructions end) ->
    #     {:ok, "memes"} mamaco whatsapp jr

    #   true ->
    #     {:error, "invalid instructions"}
    #   end
    # end
    instructions
    |> String.to_charlist()
    |> Enum.reduce_while(robot, fn
      ?A, robot ->
        {ox, oy} = robot.position

        {nx, ny} = Map.get(@movement, robot.direction)

        {:cont, %{robot | position: {ox + nx, oy + ny}}}

      ?L, robot ->
        {:cont, %{robot | direction: Map.get(@left, robot.direction)}}

      ?R, robot ->
        {:cont, %{robot | direction: Map.get(@right, robot.direction)}}

      _, robot ->
        {:halt, {:error, "invalid instruction"}}
    end)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
