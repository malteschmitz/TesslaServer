#!/usr/bin/env ruby

def median(arr)
  arr.sort!
  l = arr.size
  if l % 2 == 1
    arr[l/2]
  else
    (arr[l/2 - 1] + arr[l/2]) / 2.0
  end
end

# https://en.wikipedia.org/wiki/Median_absolute_deviation
def mad(arr)
  m = median(arr)
  deviation = arr.map{|x| (x - m).abs}
  median(deviation)
end

# standard deviation
def sigma(arr)
  mad(arr) * 1.4826
end

# standard error of the mean (SEM)
def error(arr)
  sigma(arr) / Math.sqrt(arr.size)
end

def avg(arr)
  arr.sum / arr.size
end

outlier_rejection = 3

puts "file,outliers,memory (B),error (B),relative error (%)"

for file in ARGV
  data = File.readlines(file).map(&:to_f)
  data_median = median(data)
  max = outlier_rejection * sigma(data)
  without_outliers = data.select{|x| (data_median - x).abs < max}
  num_outliers = data.size - without_outliers.size
  data_error = error(without_outliers)
  data_avg = avg(without_outliers)
  rel_error = data_error / data_avg
  puts "#{file},#{num_outliers},#{'%.3e' % data_avg},#{'%.3e' % data_error},#{'%.1f' % (rel_error*100)}"
end
