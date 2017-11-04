defmodule Portal.Door do
  @doc """
  Start a door with the given `color`

  The color is given as a name so we can identify
  the door by color name instead using PID
  """
  def start_link(color) do
    Agent.start(fn -> [] end, name: color)
  end

  @doc """
  Get the data currently in the door
  """
  def get(door) do
    Agent.get(door, fn(list) -> list end)
  end

  @doc """
  Pushs `value` into the door
  """

  def push(door, value) do
    Agent.update(door, fn(list) -> [value|list] end)
  end

  @doc """
  Pops a value from the `door`

  Return `{ :ok, value }` if there is a value
  or `:error` if the hole is currently empry
  """
  def pop(door) do
    Agent.get_and_update(door, fn
      [] -> { :error, [] }
      [h|t] -> { { :ok, h }, t}
    end)
  end
end
