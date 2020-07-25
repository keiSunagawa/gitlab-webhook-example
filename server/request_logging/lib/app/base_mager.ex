defmodule BaseMager.MREvent do
  defstruct [
    :project_path,
    :mr_iid,
    :target_branch,
    :source_branch,
    :state
  ]
end

defmodule BaseMager do
  def run(ev) do
    IO.inspect "== run base mager =="
    IO.inspect ev
  end
end
