class APIClient
  BASE_URL = "https://jsonplaceholder.typicode.com".freeze

  def fetch_issue(id)
    client.get("posts/#{id}").body
  end

  def smoke_test
    client.get("todos/1").body
  end

  private

  def client
    @_client ||= Faraday.new(url: BASE_URL) do |conn|
      conn.request :json
      conn.response :json
      conn.adapter Faraday.default_adapter
    end
  end
end
