require 'cgi'

class Location < ApplicationRecord
  validates :latitude, :longitude, presence: true
  validates :ip_address, uniqueness: false, allow_nil: true
  
  before_validation :geocode_address, if: :address_changed?
  before_validation :geocode_ip, if: :ip_address_changed?

  def seven_day_forecast
    raw_forecast = forecast
    return [] unless raw_forecast
    
    raw_forecast['list'].map do |f|
      {
        date: Time.at(f['dt']).to_date,
        high: f['main']['temp_max'],
        low: f['main']['temp_min']
      }
    end.first(7)
  end
  
  private

  def geocode_address
    return unless address.present?
    
    url = "#{GEOCODE_BASE_URL}/?locate=#{CGI.escape(address)}&json=1"
    url += "&auth=#{GEOCODE_API_KEY}" if GEOCODE_API_KEY.present?
    response = fetch_geocode_data(url)

    if response
      self.latitude = response['latt'].to_f
      self.longitude = response['longt'].to_f
    else
      errors.add(:address, "Could not geocode address")
    end
  end

  def geocode_ip
    return unless ip_address.present?
    
    url = "#{GEOCODE_BASE_URL}/#{ip_address}?geoit=json"
    url += "&auth=#{GEOCODE_API_KEY}" if GEOCODE_API_KEY.present?
    response = fetch_geocode_data(url)

    if response
      self.latitude = response['latt'].to_f
      self.longitude = response['longt'].to_f
    else
      errors.add(:ip_address, "Could not geocode IP address")
    end
  end

  def fetch_geocode_data(url)
    begin
      response = HTTP.get(url)
      data = JSON.parse(response.body)
      
      if data['error'].present?
        Rails.logger.error "Geocoding error: #{data['error']['description']}"
        return nil
      end

      return data if data['latt'].present? && data['longt'].present?
    rescue HTTP::Error, JSON::ParserError => e
      Rails.logger.error "Geocoding service error: #{e.message}"
    end
    nil
  end

  def forecast
    Rails.logger.debug "Fetching forecast for: #{latitude}, #{longitude}"
    return nil unless latitude && longitude
  
    url = "https://api.open-meteo.com/v1/forecast?latitude=#{latitude}&longitude=#{longitude}&daily=temperature_2m_max,temperature_2m_min&temperature_unit=fahrenheit&timezone=America/New_York"
    
    response = HTTP.get(url)
    data = JSON.parse(response.body)
    
    {
      'list' => data['daily']['time'].map.with_index do |date, i|
        {
          'dt' => Time.parse(date).to_i,
          'main' => {
            'temp_max' => data['daily']['temperature_2m_max'][i],
            'temp_min' => data['daily']['temperature_2m_min'][i]
          }
        }
      end
    }
  end
end
