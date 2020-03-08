require_relative 'request'

DEBUG = ENV['DEBUG']

module GithubData

  def self.process_repos(fetched_repos)
    repos = {}
    topics = Hash.new { |hash, key| hash[key] = {} }

    for fetched_repo in fetched_repos do
      if DEBUG
        puts "FETCHED #{fetched_repo["name"]}"
      end

      repo_topics = fetched_repo['repositoryTopics']['nodes']
      # TODO Use other attributes. For now just repo name.
      topics_of_fetched_repo = repo_topics.map { |t| t['topic']['name'] }

      # We can't use symbols here as Jekyll can't use symbols.
      # A class or struct was not practical so an ad hoc hash is used here.
      repo = {}
      repo['name'] = fetched_repo['name']
      repo['created_at'] = fetched_repo['createdAt']
      repo['stars'] = fetched_repo['stargazers']['totalCount']
      repo['topics'] = topics_of_fetched_repo

      repos[repo['name']] = repo

      for topic in topics_of_fetched_repo do
        if DEBUG
          puts "  TOPIC #{topic}"
        end

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
