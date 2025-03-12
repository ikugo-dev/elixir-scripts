defmodule Reverse do
  def number(old, new \\ 0)
  def number(0, new), do: new

  def number(old, new) do
    digit = Integer.mod(old, 10)
    old = Integer.floor_div(old, 10)
    new = new * 10 + digit
    number(old, new)
  end
end

[arg] = System.argv()
IO.puts(Reverse.number(String.to_integer(arg)))

# 1234
# 4321
