require 'pry'

# a = [{"count"=>"1", "label"=>"理财"}, {"count"=>"1", "label"=>"贷款"}, {"count"=>"2", "label"=>"理财/贷款"}]
# a.each_with_index { |value, i|
#   binding.pry
#   print "#{i}. #{value['count']}#{value['label']}"
#   i += 1
#   print  a= {"count" => "#{value['count']}", "label" => "#{value['label']}"}
# }

# a = ["dog", "cat", "mouse"]
# a.each_with_index do |value, index|
#   puts "#{index+1}. #{value}"
# end

# a = [{"details_key"=>"地址", "details_value"=>"北京"},
#  {"details_key"=>"累计借入本金", "details_value"=>"¥293,500.00"},
#  {"details_key"=>"性别", "details_value"=>"男"},
#  {"details_key"=>"累计已还金额", "details_value"=>"¥181,110.25"},
#  {"details_key"=>"最大逾期天数", "details_value"=>"246 天"}]
# a = [{"details_key"=>"地址", "details_value"=>"北京"},
#  {"details_key"=>"累计借入本金", "details_value"=>"¥293,500.00"},
#  {"details_key"=>"性别", "details_value"=>"男"}]
# a.each_with_index { |value, i|
#   binding.pry
#   print "#{i}. #{value['details_key']}#{value['details_value']}"
#   i += 1
#   print  a= {"details_key" => "#{value['details_key']}", "details_value" => "#{value['details_value']}"}
# }

p Dir.pwd
