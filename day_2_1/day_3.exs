defmodule IntcodeComputer do
  def compute do
    {:ok, file} = File.read("intcode.txt")
    int_codes = file |> String.trim |> String.split(",") |> Enum.map(&String.to_integer/1)
    step = 4
    resolve_block(int_codes, step, 0, step - 1)
  end

  def resolve_block(int_codes, step, slice_start, slice_end) do
    block = int_codes |> Enum.slice(slice_start..slice_end)
    int_codes = calculate_block(int_codes, block)
    case int_codes do
      {:halt, codes} -> codes
      _ -> resolve_block(int_codes, step, slice_start + step, slice_end + step)
    end
  end

  def calculate_block(int_codes, [1 | tail]) do
    {x, y} = find_value(int_codes)
    value = x + y
    int_codes |> List.replace_at(Enum.at(tail, 2), value)
  end

  def calculate_block(int_codes, [2 | tail]) do
    {x, y} = find_value(int_codes)
    value = x * y
    int_codes |> List.replace_at(Enum.at(tail, 2), value)
  end

  def calculate_block(int_codes, [99 | _]), do: {:halt, int_codes}
  def calculate_block(int_codes, []), do: {:halt, int_codes}

  def find_value(int_codes, x \\ 0, y \\ 1) do
    x = Enum.at(int_codes, Enum.at(tail, x))
    y = Enum.at(int_codes, Enum.at(tail, y))
    {x, y}
  end
end

IO.puts(inspect(IntcodeComputer.compute))
