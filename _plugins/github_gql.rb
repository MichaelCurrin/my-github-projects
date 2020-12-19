# Query the API and make the results available as Liquid variables.
require_relative "process"

module GitHubGQL
  class Generator < Jekyll::Generator
    @@QUERY_PATH = "repos_with_topics.gql"

    def read_env()
      @disable_gql = ENV["DISABLE_GQL"]
      @debug = ENV["DEBUG"]

      @token = ENV["GITHUB_TOKEN"]
      unless @token
        raise "GitHub API token must be set"
      end
    end

    def query
      if @disable_gql
        @repos = {}
        @topics = {}
      else
        gh_api = Process::GitHubAPI.new(@token, @@QUERY_PATH, @debug)
        @repos, @topics = gh_api.get_repos_and_topics
      end
    end

    def generate(site)
      self.read_env
      self.query

      site.data["all_repos"] = @repos
      site.data["all_topics"] = @topics
    end
  end
end
