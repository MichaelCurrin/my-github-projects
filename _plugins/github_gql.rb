require_relative 'process'

module GithubGQL
  class Generator < Jekyll::Generator
    safe: true

    def generate(site)
      repos, topics = GithubData.get_gh_data

      site.data['all_repos'] = repos
      site.data['all_topics'] = topics

      if ENV['DEBUG']
        puts JSON.pretty_generate topics
      end
    end
  end
end
