Searchkick.client = Elasticsearch::Client.new(
  url: "https://localhost:9200",
  user: "elastic",
  password: "X4aSPvfXdmMYsZs-3L+h",
  transport_options: {
    ssl: {
      ca_file: Rails.root.join("config/http_ca.crt").to_s
    }
  }
)
