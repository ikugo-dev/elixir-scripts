defmodule WordSearch do
  @spec search_file(String.t(), String.t()) :: :ok
  def search_file(file_name, word \\ "/") do
    case File.read(file_name) do
      {:ok, file_content} ->
        file_content
        |> search(word)
        |> Enum.sort_by(fn {_key, value} -> value end)
        |> Enum.each(fn {key, value} -> IO.puts("#{key}: #{value}") end)

      {:error, reason} ->
        IO.puts("Cant read the file because of #{reason} error.")
    end
  end

  @spec search(String.t(), String.t()) :: map()
  defp search(haystack, needle) when needle != "/" do
    repetition =
      haystack
      |> parse_text()
      |> Enum.count(&(&1 == needle))

    %{needle => repetition}
  end

  @spec search(String.t(), String.t()) :: map()
  defp search(haystack, _needle) do
    haystack
    |> parse_text()
    |> Enum.reduce(%{}, fn key, acc ->
      Map.update(acc, key, 1, &(&1 + 1))
    end)
  end

  @spec parse_text(String.t()) :: list(String.t())
  defp parse_text(content) do
    content
    |> String.downcase()
    |> String.replace(~r/[^\w\s]/u, "")
    |> String.split(~r/\s+/)
  end
end

[file_name | word] = System.argv() ++ ["/"]
WordSearch.search_file(file_name, hd(word))
