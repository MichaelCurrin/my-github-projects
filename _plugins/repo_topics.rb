module RepoTopics
  class Generator < Jekyll::Generator

    def generate(site)
      token = ENV['ACCESS_TOKEN']
      unless token
        raise 'Env variable ACCESS_TOKEN must be set'
      end

      site.data['topics'] = ['foo', 'bar', 'baz']
    end
  end
end
