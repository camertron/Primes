#!/usr/bin/ruby

require 'prime'
require 'timeout'

reference_results = {
  10 => 4,
  100 => 25,
  1000 => 168,
  10000 => 1229,
  100000 => 9592,
  1000000 => 78498,
  10000000 => 664579,
  100000000 => 5761455
}

sieve_size = 1000000
pass_count = 0
prime_count = 0

# warmup for jit, default is 5 calls
5.times { Prime.each(sieve_size).count }

start_time = Time.now.to_f

begin
  # run for 5 seconds
  Timeout.timeout(5) do
    loop do
      # ruby stdlib contains a very performant sieve implementation
      # in the Prime class
      prime_count = Prime.each(sieve_size).count
      pass_count += 1
    end
  end
rescue Timeout::Error
  # timeout raises an error when time expires
end

duration = (Time.now.to_f - start_time).round(3)

unless reference_results[sieve_size] == prime_count
  puts "WARNING: result is incorrect!"
end

puts "camertron;#{pass_count};#{duration};1;algorithm=base,faithful=yes"
