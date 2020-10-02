require 'json'
require_relative 'request'


# TODO use the plugin in the directory above to make modular. Consider how it can be a dependency for this plugin or maybe keep it all in one to keep it simple.
# From https://www.programming-idioms.org/idiom/173/format-a-number-with-grouped-thousands/2440/ruby
def thousands_separator(value)
  value.to_s.gsub(/\B(?=(...)*\b)/, ',')
end

class GitHubAPI
  @@API_URL = 'https://api.github.com/graphql'

  def initialize(token, query_filename, debug)
    @headers = {
      'Authorization': "token #{token}",
      'Content-Type': "application/json",
    }
    @payload = format_payload(query_filename)
    @debug = debug

    @fetched_repos = []
  end

  def format_payload(query_filename)
    query_path = File.join File.dirname(__FILE__), query_filename
    query_contents = File.open(query_path).read

    {'query': query_contents}
  end

  def parse_repo(repo)
    if @debug == '2'
      puts "REPO RAW DATA"
      puts JSON.pretty_generate repo
    end

    # Handle edge-case of an empty repo.
    branch = repo['defaultBranchRef']
    if branch
      total_commits = branch['commits']['history']['totalCount']
    else
      total_commits = 0
    end

    topics = repo['repositoryTopics']['nodes']

    # We can't use symbols here as Jekyll can't handle symbols.
    # A class or struct was not practical so hash is used here.
    {
      'name' => repo['name'],
      'url' => repo['url'],
      'description' => repo['description'],

      'created_at' => repo['createdAt'],
      'updated_at' => repo['updatedAt'],

      'stars' => repo['stargazers']['totalCount'],
      'forks' => repo['forkCount'],
      'total_commits' => total_commits,

      'topics' => topics.map { |t| t['topic']['name'] },
    }
  end

  def process_repos
    repos = {}
    # Structure where key is topic name and value is a hash with key as repo name and
    # value as hash of repo attributes.
    topics = Hash.new { |hash, key| hash[key] = {} }

    @fetched_repos.each do |fetched_repo|
      if @debug
        puts "FETCHED #{fetched_repo["name"]}"
      end

      repo = self.parse_repo(fetched_repo)
      repos[repo['name']] = repo

      repo_topics = fetched_repo['repositoryTopics']['nodes']
      # TODO Use other attributes. For now just repo name.
      topics_of_fetched_repo = repo_topics.map { |t| t['topic']['name'] }

      for topic in topics_of_fetched_repo do
        if @debug
          puts "  TOPIC #{topic}"
        end

        # TODO: Can this be refactored to one line?
        stored_topics = topics[topic]
        stored_topics[repo['name']] = repo
        topics[topic] = stored_topics
      end
    end

    [repos, topics]
  end

  def request
    req = Request.new(@@API_URL, @headers, @payload)
    resp_data = req.query()
    @fetched_repos = resp_data['viewer']['repositories']['nodes']
  end

  def get_gh_data
    self.request
    self.process_repos
  end
end
