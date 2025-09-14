require 'net/http'

class Api::V1::CandidatesController < ApplicationController
  def index
    url = URI("https://randomuser.me/api/?results=20&nat=us,fr,gb,tr,de")
    raw = Net::HTTP.get(url)
    data = JSON.parse(raw)

    candidates = data.fetch("results", []).map do |c|
      {
        id: c.dig("login", "uuid"),
        name: [c.dig("name", "first"), c.dig("name", "last")].compact.join(" "),
        email: c["email"],
        city: c.dig("location", "city"),
        country: c.dig("location", "country"),
        avatar: c.dig("picture", "thumbnail")
      }
    end

    render json: candidates
  rescue => e
    Rails.logger.error("Candidates fetch failed: #{e.class} #{e.message}")
    render json: [], status: :bad_gateway
  end
end
