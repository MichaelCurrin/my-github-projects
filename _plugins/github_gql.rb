require_relative 'process'

module GithubGQL
  class Generator < Jekyll::Generator

    def generate(site)
      if ENV['DISABLE_GQL']
        repos = {}
        topics = {}
      else
        repos, topics = GithubData.get_gh_data
      end

      site.data['all_repos'] = repos
      site.data['all_topics'] = topics
    end
  end
end
