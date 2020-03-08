require_relative 'request'

DEBUG = ENV['DEBUG']

module GithubData

  def self.parse_repo(fetched_repo)
    # We can't use symbols here as Jekyll can't use symbols.
    # A class or struct was not practical so an ad hoc hash is used here.
    repo = {}
    repo['name'] = fetched_repo['name']
    repo['created_at'] = fetched_repo['createdAt']
    repo['stars'] = fetched_repo['stargazers']['totalCount']

    fetched_topics = fetched_repo['repositoryTopics']['nodes']
    # List of topic names.
    repo['topics'] = fetched_topics.map { |t| t['topic']['name'] }

    repo
  end

  def self.process_repos(fetched_repos)
    repos = {}
    # Structure where key is topic name and value is a hash with key as repo name and
    # value as hash of repo attributes.
    topics = Hash.new { |hash, key| hash[key] = {} }

    for fetched_repo in fetched_repos do
      if DEBUG
        puts "FETCHED #{fetched_repo["name"]}"
      end

      repo = self.parse_repo(fetched_repo)
      repos[repo['name']] = repo

      repo_topics = fetched_repo['repositoryTopics']['nodes']
      # TODO Use other attributes. For now just repo name.
      topics_of_fetched_repo = repo_topics.map { |t| t['topic']['name'] }

      for topic in topics_of_fetched_repo do
        if DEBUG
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

  def self.get_gh_data
    resp_data = Request.query
    fetched_repos = resp_data['viewer']['repositories']['nodes']
    self.process_repos(fetched_repos)
  end
end
