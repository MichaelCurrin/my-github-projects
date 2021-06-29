# Request module.
#
# Do a request to the GitHub GraphQL API and return data.
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
    if resp.status > 299
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

    puts "Pretty printed response"
    puts JSON.pretty_generate data
  end
end
