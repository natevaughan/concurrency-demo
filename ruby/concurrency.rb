require 'uri'
require 'net/http'
require 'json'

class CatFact
  attr_reader :fact, :length

  def initialize(hash)
    hash.each {|k,v| instance_variable_set("@#{k}",v)}
  end
end

uri = URI("https://catfact.ninja/fact")
start = Time.now
timings = [ 0.730, 0.306, 1.034, 2.843, 1.790 ]
facts = []
timings.each do |timing|
  sleep(timing)
  res = Net::HTTP.get_response(uri)
  if res.is_a?(Net::HTTPSuccess)
    facts << CatFact.new(JSON.parse(res.body))
  end
end
ending = Time.now
puts facts.map { |fact| fact.fact }
puts "Serial execution time: #{ending - start}"

start = Time.now
timings = [ 0.730, 0.306, 1.034, 2.843, 1.790 ]
threads = []
facts = []
timings.each do |timing|
  threads << Thread.new do
    sleep(timing)
    res = Net::HTTP.get_response(uri)
    if res.is_a?(Net::HTTPSuccess)
      facts << CatFact.new(JSON.parse(res.body))
    end
  end
end
threads.each(&:join)
ending = Time.now
puts facts.map { |fact| fact.fact }
puts "Concurrency execution time: #{ending - start}"
