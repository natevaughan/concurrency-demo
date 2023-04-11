
class CatFact
  attr_reader :fact, :length

  def initialize(fact, length)
    @fact = fact
    @length = length
  end
end

start = Time.now
timings = [ 0.730, 0.306, 1.034, 2.843, 1.790 ]
facts = []
timings.each do |timing|
  sleep(timing)
  facts << CatFact.new(timing > 1.5 ? 'Cats have nine lives' : 'Cats always land on their feet', timing)
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
    facts << CatFact.new(timing > 1.5 ? 'Cats have nine lives' : 'Cats always land on their feet', timing)
  end
end
threads.each(&:join)
ending = Time.now
puts facts.map { |fact| fact.fact }
puts "Concurrency execution time: #{ending - start}"
