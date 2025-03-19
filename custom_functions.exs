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

  def map(array, transform, index \\ 0) do
    if index >= length(array) do
      []
    else
      remaining = map(array, transform, index + 1)

      [transform.(Enum.at(array, index))] ++ remaining
    end
  end

  def take(array, up_to, index \\ 0) do
    if index >= length(array) || index >= up_to do
      []
    else
      remaining = take(array, up_to, index + 1)

      [Enum.at(array, index)] ++ remaining
    end
  end

  def reduce(list, accumulator, fun) do
    case list do
      [] -> accumulator
      _ -> reduce(tl(list), fun.(hd(list), accumulator), fun)
    end
  end

  def reverse(array, index \\ 0) do
    if index >= length(array) do
      []
    else
      reverse(array, index + 1) ++ [Enum.at(array, index)]
    end
  end

  # def filter_reduce(array, condition, index \\ 0) do
  # end

  def map_reduce(array, transform) do
    array
    |> reduce([], fn x, acc -> [transform.(x) | acc] end)
    |> reverse()
  end
end

array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

# CustomFunctions.loop(array, &IO.puts/1)
CustomFunctions.filter(array, &(rem(&1, 2) != 0))
|> CustomFunctions.map(&(&1 * 2))
# |> CustomFunctions.take(5)
|> IO.inspect()

CustomFunctions.filter(array, &(rem(&1, 2) != 0))
|> CustomFunctions.map_reduce(&(&1 * 2))
|> IO.inspect()

# fun = &(&1 * 2)
# CustomFunctions.reduce(array, 0, &(&1 + &2))
# |> IO.inspect()
