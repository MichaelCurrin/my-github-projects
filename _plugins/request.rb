# Request application.
#
# Do a request to the Github GraphQL API, handle errors and pretty print the parsed response data.
#
# self was used in the module as per this page.
#   https://stackoverflow.com/questions/322470/can-i-invoke-an-instance-method-on-a-ruby-module-without-including-it
require 'json'
require 'faraday'

module Request
  API_URL = 'https://api.github.com/graphql'

  TOKEN = ENV['ACCESS_TOKEN']
  unless TOKEN
    raise 'Env variable ACCESS_TOKEN must be set'
  end
  HEADERS = {
    'Authorization': "token #{TOKEN}",
    'Content-Type': "application/json",
  }

  QUERY_PATH = File.join File.dirname(__FILE__), 'repos_with_topics.gql'
  QUERY = File.open(QUERY_PATH).read

  def self.post(url, payload)
    puts "Do POST request"

    resp = Faraday.post(
      url,
      payload.to_json,
      HEADERS,
    )
    puts "Status: #{resp.status}"
    if resp.status != 200
      puts "Body:"
      puts resp.body
      raise "Request status: #{resp.status}"
    end
    resp_data = JSON.parse resp.body
  end

  def self.query()
    query_payload = {'query': QUERY}
    results = post API_URL, query_payload

    errors = results['errors']
    if errors
      puts 'Errors on response:'
      puts JSON.pretty_generate errors
      raise "Request error!"
    end

    results['data']
  end

  def self.test
    data = self.query()
    puts JSON.pretty_generate data
  end
end
