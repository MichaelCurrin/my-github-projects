# Query the GraphQL API and process the data.
require "json"
require_relative "request"

module Process
  def self.total_commits_of_repo(repo)
    # Get count of total commits, but allow branch to be not set for an empty repo edge-case.
    branch = repo["defaultBranchRef"]

    branch ? branch["commits"]["history"]["totalCount"] : 0
  end

  def self.topics_as_names(fetched_repo)
    topics = fetched_repo["repositoryTopics"]["nodes"]
    topics.map { |t| t["topic"]["name"] }
  end

  def self.repo_as_hash(repo, total_commits, topic_names)
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

      "topics" => topic_names,
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

      total_commits = Process::total_commits_of_repo(repo)
      topic_names = Process::topics_as_names(repo)

      Process::repo_as_hash(repo, total_commits, topic_names)
    end

    def extract_repos_and_topics(fetched_repos)
      fetched_repos.each do |fetched_repo|
        if @debug
          puts "FETCHED #{fetched_repo["name"]}"
        end

        repo = self.parse_repo(fetched_repo)

        topic_names = Process::topics_as_names(fetched_repo)
        topic_names.each do |topic|
          if @debug
            puts "  TOPIC #{topic}"
          end

          @topics[topic][repo["name"]] = repo
        end

        @repos[repo["name"]] = repo
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
