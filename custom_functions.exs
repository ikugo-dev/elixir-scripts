defmodule CustomFunctions do
  def loop(array, fun, index \\ 0) do
    if index < length(array) do
      fun.(Enum.at(array, index))
      loop(array, fun, index + 1)
    end
  end

  def filter(array, condition, index \\ 0) do
    if index >= length(array) do
      []
    else
      remaining = filter(array, condition, index + 1)

      if condition.(Enum.at(array, index)) do
        [Enum.at(array, index)] ++ remaining
      else
        remaining
      end
    end
  end

  def map do
  end

  def reduce do
  end
end

array = [1, 2, 3, 4, 5, 6, 7, 8]

# CustomFunctions.loop(array, &IO.puts/1)
CustomFunctions.filter(array, fn x ->
  rem(x, 2) != 0
end)
|> IO.inspect()

# |> IO.puts()
