# Query the API and make the results available as Liquid variables.
require_relative "process"

module GitHubGQL
  QUERY_PATH = "repos_with_topics.gql"

  class Generator < Jekyll::Generator
    def generate(site)
      token = ENV["GITHUB_TOKEN"]
      disable_gql = ENV["DISABLE_GQL"]
      debug = ENV["DEBUG"]

      unless token
        raise "GitHub API token must be set"
      end

      if disable_gql
        repos = {}
        topics = {}
      else
        gh_api = Process::GitHubAPI.new(token, QUERY_PATH, debug)
        repos, topics = gh_api.get_gh_data
      end

      site.data["all_repos"] = repos
      site.data["all_topics"] = topics
    end
  end
end
