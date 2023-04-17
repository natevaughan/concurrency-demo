require 'uri'
require 'net/http'
require 'json'

class Listing
  attr_reader :import_id, :external_id, :vrbo_id, :title, :location, :bedrooms, :bathrooms, :reviews_count, :rating, :max_guests, :isActive, :balance, :property_type, :name, :gender, :company, :email, :phone, :address, :about, :created_at, :updated_at, :disabled_at, :amenities, :images

  def initialize(hash)
    hash.each {|k,v| instance_variable_set("@#{k}",v)}
  end
end

start = Time.now
file_names = %w[generated_0.json generated_1.json generated_2.json generated_3.json generated_4.json generated_5.json generated_6.json generated_7.json generated_8.json generated_9.json]
listings = []
file_names.each do |file_name|
  uri = URI("http://localhost:2345/#{file_name}")
  res = Net::HTTP.get_response(uri)
  if res.is_a? Net::HTTPSuccess
    json_arr = JSON.parse(res.body)
    json_arr.each do |h|
      listing = Listing.new(h)
      listings << listing
    end
  end
end

ending = Time.now
puts "Serial fetch time: #{ending - start}, #{listings.length}"

start = Time.now
threads = []
listings = []
file_names.each do |file_name|
  threads << Thread.new do
    uri = URI("http://localhost:2345/#{file_name}")
    res = Net::HTTP.get_response(uri)
    if res.is_a?(Net::HTTPSuccess)
      json_arr = JSON.parse(res.body)
      json_arr.each do |h|
        listing = Listing.new(h)
        listings << listing
      end
    end
  end
end
threads.each(&:join)
ending = Time.now
puts "Concurrency execution time: #{ending - start}, #{listings.length}"

sort_start = Time.now
listings.sort_by.sort_by { |listing|
  listing.rating * Math.log(listing.reviews_count)
}
sort_end = Time.now
puts "Sort execution time: #{sort_end - sort_start}, #{listings.length}"