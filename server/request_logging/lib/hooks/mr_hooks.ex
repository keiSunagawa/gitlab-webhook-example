defmodule Hooks.MRHooks do
  def logging(e) do
    IO.puts "== logging == "
    IO.inspect e
  end

  def base_merger(e) do
    if e["object_attributes"]["action"] == "merge" do
      ev = base_merger_conv(e)
      BaseMager.run(ev)
    end
  end

  defp base_merger_conv(e) do
    %BaseMager.MREvent {
      project_path: e["project"]["path_with_namespace"],
      mr_iid: e["object_attributes"]["iid"],
      target_branch: e["object_attributes"]["target_branch"],
      source_branch: e["object_attributes"]["source_branch"],
      state: e["object_attributes"]["state"]
    }
  end
end
