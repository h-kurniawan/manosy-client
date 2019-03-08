class APIClient
  BASE_URL = "https://mns-api.imedidata.net/api/v1".freeze

  def fetch_downtime(id)
    client.get("downtimes/#{id}").body.with_indifferent_access
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
