defmodule FizzBuzz do
  def run(n) when n > 0 do
    1..n
    |> Enum.map(&fun/1)
    |> Enum.each(&IO.puts/1)
  end

  defp fun(n) do
    cond do
      rem(n, 15) == 0 -> "FizzBuzz"
      rem(n, 5) == 0 -> "Buzz"
      rem(n, 3) == 0 -> "Fizz"
      true -> Integer.to_string(n)
    end
  end
end

[arg] = System.argv()
FizzBuzz.run(String.to_integer(arg))
