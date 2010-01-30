require 'benchmark'

n = 10_000

Benchmark.bmbm do |x|
  data = "abc" * 100
  x.report("SHA2") do
    require 'sha1'
    n.times { |i| Digest::SHA2.hexdigest(data) }
  end

  x.report("MD5") do
    require 'md5'
    n.times { |i| Digest::MD5.hexdigest(data) }
  end
end
