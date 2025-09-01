require 'net/http'

class Api::V1::CandidatesController < ApplicationController
  def index
    url = URI("https://randomuser.me/api/?results=20&nat=us,gb,tr,de,fr")
    raw = Net::HTTP.get(url)
    data = JSON.parse(raw)

    rows = data.fetch("results", []).map do |r|
      {
        id:       r.dig("login", "uuid"),
        name:     [r.dig("name", "first"), r.dig("name", "last")].compact.join(" "),
        email:    r["email"],
        city:     r.dig("location", "city"),
        country:  r.dig("location", "country"),
        avatar:   r.dig("picture", "thumbnail"),
      }
    end

    render json: rows
  rescue => e
    Rails.logger.error("Candidates fetch failed: #{e.class} #{e.message}")
    render json: [], status: :bad_gateway
  end
end
