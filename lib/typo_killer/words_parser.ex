defmodule TypoKiller.WordsParser do
  @moduledoc """
  Manage words from files and parse them to analyze if they are possible typos or not
  """

  @doc """
  Retrieve words from files and generate a new mapset based on filters
  """
  @spec files_to_words(files :: list(String.t()) | []) :: MapSet.t()
  def files_to_words(files)

  def files_to_words(files) when is_list(files) and length(files) == 0, do: MapSet.new()

  def files_to_words(files) when is_list(files) and length(files) > 0 do
    files
    |> Enum.flat_map(&find_words/1)
    |> MapSet.new()
  end

  def file_to_words(file) do
    file
    |> find_words()
    |> MapSet.new()
  end

  defp find_words(file) do
    file
    |> File.read!()
    |> String.downcase()
    |> String.split(["\n", "_", " "], trim: true)
    |> Enum.flat_map(&Regex.split(~r/[^a-zA-Z]+/, &1, trim: true))
  end
end
