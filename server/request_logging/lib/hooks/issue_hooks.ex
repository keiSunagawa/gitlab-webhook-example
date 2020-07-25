# defmodule IssueEvent do
#   defstruct [:]
# end
defmodule Hooks.IssueHooks do
  def logging(e) do
    IO.puts "== logging == "
    IO.inspect e
  end
end
