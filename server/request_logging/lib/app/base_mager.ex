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
  @target_project "root/foo"
  @baseBranch "master"
  @stalkerBranch "staging"

  def run(ev) do
    if (
      ev.project_path == @target_project and
      ev.target_branch == @stalkerBranch and
      !mr_exists?(ev.project_path, @stalkerBranch, @baseBranch)
    ) do
      # create mr
      External.RestAPIClient.create_mr(ev.project_path, @stalkerBranch, @baseBranch)
      # send notice
    end
  end

  def mr_exists?(project, source, target) do
    q = """
    query {
      project(fullPath:"#{project}") {
        mergeRequests(
          targetBranches:["#{target}"],
          state: opened
        ) {
          nodes {
            iid,
            title,
            sourceBranch
          }
        }
      }
    }
    """
    res = External.GraphqlClient.query(q)
    IO.inspect res
    res["data"]["project"]["mergeRequests"]["nodes"] |> Enum.any?(fn n ->
      n["sourceBranch"] == source
    end)
  end
end
