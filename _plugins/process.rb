# Query the GraphQL API and process the data.
require "json"
require_relative "request"

module Process
  # TODO remove as unused.
  # TODO use the plugin in the directory above to make modular. Consider how it can be a dependency
  # for this plugin or maybe keep it all in one to keep it simple.
  # From:
  #   https://www.programming-idioms.org/idiom/173/format-a-number-with-grouped-thousands/2440/ruby
  def thousands_separator(value)
    value.to_s.gsub(/\B(?=(...)*\b)/, ",")
  end

  def self.repo_as_hash(repo, total_commits, topics)
    # We can't use symbols here as Jekyll can't handle symbols.
    # A class or struct was not practical so hash is used here.
    {
      "name" => repo["name"],
      "url" => repo["url"],
      "description" => repo["description"],

      "created_at" => repo["createdAt"],
      "updated_at" => repo["updatedAt"],

      "stars" => repo["stargazers"]["totalCount"],
      "forks" => repo["forkCount"],
      "total_commits" => total_commits,

      "topics" => topics.map { |t| t["topic"]["name"] },
    }
  end

  class GitHubAPI
    @@API_URL = "https://api.github.com/graphql"

    def initialize(token, query_filename, debug)
      @headers = {
        'Authorization': "token #{token}",
        'Content-Type': "application/json",
      }
      @payload = format_payload(query_filename)
      @debug = debug

      @fetched_repos = []

      @repos = {}
      # Key must be topic name.
      # Value must be a hash, with key as repo name and value as hash of repo attributes.
      @topics = Hash.new { |hash, key| hash[key] = {} }
    end

    def request
      req = Request.new(@@API_URL, @headers, @payload)
      resp_data = req.query()
      user = resp_data["viewer"]
      @fetched_original_repos = user["originalRepos"]["nodes"]
      @fetched_forked_repos = user["forkedRepos"]["nodes"]
    end

    def format_payload(query_filename)
      query_path = File.join File.dirname(__FILE__), query_filename
      query_contents = File.open(query_path).read

      { 'query': query_contents }
    end

    def parse_repo(repo)
      if @debug == "2"
        puts "REPO RAW DATA"
        puts JSON.pretty_generate repo
      end

      # Handle edge-case of an empty repo.
      branch = repo["defaultBranchRef"]
      if branch
        total_commits = branch["commits"]["history"]["totalCount"]
      else
        total_commits = 0
      end

      topics = repo["repositoryTopics"]["nodes"]

      Process::repo_as_hash(repo, total_commits, topics)
    end

    def extract_repos_and_topics(fetched_repos)
      fetched_repos.each do |fetched_repo|
        if @debug
          puts "FETCHED #{fetched_repo["name"]}"
        end

        repo = self.parse_repo(fetched_repo)
        @repos[repo["name"]] = repo

        repo_topics = fetched_repo["repositoryTopics"]["nodes"]
        # TODO Use other attributes. For now just repo name.
        topics_of_fetched_repo = repo_topics.map { |t| t["topic"]["name"] }

        topics_of_fetched_repo.each do |topic|
          if @debug
            puts "  TOPIC #{topic}"
          end

          @topics[topic][repo["name"]] = repo
        end
      end
    end

    def get_repos_and_topics
      self.request
      self.extract_repos_and_topics(@fetched_original_repos)
      self.extract_repos_and_topics(@fetched_forked_repos)

      [@repos, @topics]
    end
  end
end
