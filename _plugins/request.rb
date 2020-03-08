# Request application.
#
# Do a request to the Github GraphQL API, handle errors and pretty print the parsed response data.
#
# self was used in the module as per this page.
#   https://stackoverflow.com/questions/322470/can-i-invoke-an-instance-method-on-a-ruby-module-without-including-it
#
# TODO: This could be rewritten without self or could be made into a class.
require 'json'
require 'faraday'

module Request
  API_URL = 'https://api.github.com/graphql'
  TOKEN = ENV['GITHUB_TOKEN']
  HEADERS = {
    'Authorization': "token #{TOKEN}",
    'Content-Type': "application/json",
  }

  def self.prepare_request(query_filename)
    query_path = File.join File.dirname(__FILE__), query_filename
    query_contents = File.open(query_path).read

    {'query': query_contents}
  end

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
    unless TOKEN
      raise 'Env variable GITHUB_TOKEN must be set'
    end

    query_filename = 'repos_with_topics.gql'
    query_payload = self.prepare_request(query_filename)
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
