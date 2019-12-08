defmodule FuelCalculator do
  def required_fuel do
    {:ok, file} = File.read("modules.txt")
    modules = file |> String.trim |> String.split("\n") |> Enum.map(&String.to_integer/1)

    modules =
      modules
      |> Enum.map(fn module ->
        calculate_fuel(module, 0)
      end)

    modules |> Enum.sum
  end

  def calculate_fuel(module, accumulator) do
    module = (Float.floor(module / 3) - 2)
    case module do
      n when n > 0 ->
        calculate_fuel(module, accumulator + module)
      _ ->
        accumulator
    end
  end
end

IO.puts(inspect(FuelCalculator.required_fuel))
