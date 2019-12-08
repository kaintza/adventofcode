{:ok, file} = File.read("modules.txt")
modules = file |> String.trim |> String.split("\n") |> Enum.map(&String.to_integer/1)

modules =
  modules
  |> Enum.map(fn module ->
    Float.floor(module / 3) - 2
  end)

result = modules |> Enum.sum

IO.puts(inspect(result))
