defmodule Reverse do
  def number(old, new \\ 0)
  def number(0, new), do: new

  def number(old, new) do
    digit = Integer.mod(old, 10)
    old = Integer.floor_div(old, 10)
    new = new * 10 + digit
    number(old, new)

    # number(
    #   Integer.floor_div(old, 10),
    #   new * 10 + Integer.mod(old, 10)
    # )
  end
end

System.argv()
|> hd()
|> String.to_integer()
|> Reverse.number()
|> IO.puts()

# 1234
# 4321
