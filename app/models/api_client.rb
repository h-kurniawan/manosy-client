class APIClient
  BASE_URL = "https://jsonplaceholder.typicode.com".freeze

  def smoke_test
    @result = client.get("todos/1").body
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
