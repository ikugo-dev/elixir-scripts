# without indexing
defmodule CustomFunctions2 do
  def loop(list, fun) do
    case list do
      [] ->
        nil

      _ ->
        fun.(hd(list))
        loop(tl(list), fun)
    end
  end

  def filter(list, condition) do
    case list do
      [] ->
        []

      _ ->
        remaining = filter(tl(list), condition)

        if condition.(hd(list)) do
          [hd(list)] ++ remaining
        else
          remaining
        end
    end
  end

  def map(list, transform) do
    case list do
      [] -> []
      _ -> [transform.(hd(list))] ++ map(tl(list), transform)
    end
  end

  def take(list, up_to) do
    cond do
      list == [] -> []
      up_to <= 0 -> []
      true -> [hd(list)] ++ take(tl(list), up_to - 1)
    end
  end

  def reduce(list, accumulator, fun) do
    case list do
      [] -> accumulator
      _ -> reduce(tl(list), fun.(hd(list), accumulator), fun)
    end
  end

  def reverse(list) do
    case list do
      [] -> []
      _ -> reverse(tl(list)) ++ [hd(list)]
    end
  end

  # def filter_reduce(list, condition, index \\ 0) do
  # end

  def map_reduce(list, transform) do
    list
    |> reduce([], fn x, acc -> [transform.(x) | acc] end)
    |> reverse()
  end
end

# with indexing
defmodule CustomFunctions1 do
  def loop(list, fun, index \\ 0) do
    if index < length(list) do
      fun.(Enum.at(list, index))
      loop(list, fun, index + 1)
    end
  end

  def filter(list, condition, index \\ 0) do
    if index >= length(list) do
      []
    else
      remaining = filter(list, condition, index + 1)

      if condition.(Enum.at(list, index)) do
        [Enum.at(list, index)] ++ remaining
      else
        remaining
      end
    end
  end

  def map(list, transform, index \\ 0) do
    if index >= length(list) do
      []
    else
      remaining = map(list, transform, index + 1)

      [transform.(Enum.at(list, index))] ++ remaining
    end
  end

  def take(list, up_to, index \\ 0) do
    if index >= length(list) || index >= up_to do
      []
    else
      remaining = take(list, up_to, index + 1)

      [Enum.at(list, index)] ++ remaining
    end
  end

  def reduce(list, accumulator, fun) do
    case list do
      [] -> accumulator
      _ -> reduce(tl(list), fun.(hd(list), accumulator), fun)
    end
  end

  def reverse(list, index \\ 0) do
    if index >= length(list) do
      []
    else
      reverse(list, index + 1) ++ [Enum.at(list, index)]
    end
  end

  # def filter_reduce(list, condition, index \\ 0) do
  # end

  def map_reduce(list, transform) do
    list
    |> reduce([], fn x, acc -> [transform.(x) | acc] end)
    |> reverse()
  end
end

[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
|> CustomFunctions1.filter(&(rem(&1, 2) != 0))
|> CustomFunctions1.map(&(&1 * 2))
|> CustomFunctions1.take(5)
|> IO.inspect()
|> CustomFunctions1.loop(&IO.puts/1)

[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
|> CustomFunctions2.filter(&(rem(&1, 2) != 0))
|> CustomFunctions2.map(&(&1 * 2))
|> CustomFunctions2.take(5)
|> IO.inspect()
|> CustomFunctions2.loop(&IO.puts/1)
