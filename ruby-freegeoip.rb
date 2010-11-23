require 'rubygems'
require 'json'
require 'net/http'

class IPGeoInfo
  attr_accessor :ipcity, :ipstate, :iplat, :iplng, :ipzip, :ipmetro
  def initialize ( ip_address )
    @ip = ip_address
    @query_url = create_query_url
    @results = get_json_response
    @ipcity = @results['city']
    @ipstate = @results['region_name']
    @iplat = @results['latitude']
    @iplng = @results['longitude']
    @ipzip = @results['zipcode']
    @ipmetro = @results['metrocode']
  end
  
  def create_query_url
    'http://freegeoip.net/json/' + @ip
  end
  
  def get_json_response
    response = Net::HTTP.get_response(URI.parse(@query_url))
    JSON.parse(response.body)
  end
end




ip = '74.200.247.59'
geoinfo = IPGeoInfo.new(ip)

puts "City: #{geoinfo.ipcity}"
puts "State: #{geoinfo.ipstate}"
puts "Latitude: #{geoinfo.iplat}"
puts "Longitude: #{geoinfo.iplng}"
puts "Zip Code: #{geoinfo.ipzip}"
puts "Metro Code: #{geoinfo.ipmetro}"
