# Request application.
#
# Do a request to the Github GraphQL API, handle errors and pretty print the parsed response data.
#
# self was used in the module as per this page.
#   https://stackoverflow.com/questions/322470/can-i-invoke-an-instance-method-on-a-ruby-module-without-including-it
require "json"
require "faraday"

class Request
  def initialize(url, headers, payload)
    @url = url
    @headers = headers
    @payload = payload
  end

  def post
    puts "Do POST request"
    resp = Faraday.post(
      @url,
      @payload.to_json,
      @headers,
    )

    puts "Status: #{resp.status}"
    if resp.status != 200
      puts "Body:"
      puts resp.body
      raise "Request status: #{resp.status}"
    end

    JSON.parse resp.body
  end

  def query()
    results = self.post()

    errors = results["errors"]
    if errors
      puts "Errors on response:"
      puts JSON.pretty_generate errors
      raise "Request error!"
    end

    results["data"]
  end

  def test
    data = self.query()
    puts JSON.pretty_generate data
  end
end
