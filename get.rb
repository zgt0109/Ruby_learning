#!/usr/bin/ruby
# coding: utf-8
require 'pry'
require 'pp'
require 'json'
require 'net/http'
require 'uri'

# http://www.looklaw.cn/doc/e12848ce5d9f197ddc327819ddeeadf4
# id_no = ARGV[0]
# url = "http://www.looklaw.cn/docdemo/structor?id_no="+id_no
puts "id_no获取中..."
array = []
1.upto(200) { |no|
  # binding.pry
  # url = 'http://www.looklaw.cn/search/ZG9jOuWGs+WumuS5pjpkZWZhdWx0PeWGs+WumuS5piZkb2NfdHlwZT3lhrPlrprkuaYmY2FzZV90eXBlPeWIkeS6i+ahiOS7tiZjYXNlX25hbWU9JmNhc2VfbnVtPSZkYW5nc2hpcmVuX25hbWVzPSZsYXd5ZXJfbmFtZXM9JmZpcm1fbmFtZXM9JnNoZW5wYW5yZW5fbmFtZXM9JmZheXVhbl9uYW1lcz0manVkZ2VfbGV2ZWw95LiA5a6h.html?p='+no.to_s
  url = 'http://www.looklaw.cn/search/ZG9jOuWGs+WumuS5pjpkZWZhdWx0PeWGs+WumuS5piZkb2NfdHlwZT3lhrPlrprkuaYmY2FzZV90eXBlPeWIkeS6i+ahiOS7tiZjYXNlX25hbWU9JmNhc2VfbnVtPSZkYW5nc2hpcmVuX25hbWVzPSZsYXd5ZXJfbmFtZXM9JmZpcm1fbmFtZXM9JnNoZW5wYW5yZW5fbmFtZXM9JmZheXVhbl9uYW1lcz0manVkZ2VfbGV2ZWw95LqM5a6h.html?p='+no.to_s
  uri = URI.parse url
  result = Net::HTTP.get uri
  result = result.force_encoding('utf-8')
  # href="\/doc\/(.*)\.html\?kw=决定书"
  a = result.scan(/href="\/doc\/(.*)\.html\?kw=决定书"/u).flatten
  array = array << a
}
# binding.pry
array = array.flatten
puts "id_no获取完毕"
puts "id_no的个数是：#{array.length}"

error_array = []
File.new("error","a+")

array.each_with_index do |id_no, i|
  url = "http://www.looklaw.cn/docdemo/structor?id_no="+id_no
  # binding.pry
  uri = URI.parse url
  result =  Net::HTTP.get uri
  res = JSON.parse result
  resp = res[0]
  case_num = resp['case_num']
  id_no = resp['id_no']
  doc_id = resp['doc_id' ]
  case_type = resp['case_type']
  anyou_code = resp['anyou_code']
  anyou_name = resp['anyou_name']
  fayuan_name = resp['fayuan_name']
  origin_content = resp['origin_content']
  fayuan_renwei = resp['fayuan_renwei']
  doc_type = resp['doc_type']
  judge_level = resp['judge_level']
  # pp origin_content
  puts "*"*50+"第#{i+1}条"+"*"*50

  # 调用本地接口测试
  url = URI.parse('http://localhost:3000/looklaw')
  data = {
      'case_type': case_type.sub('案件',''),
      'judge_level': judge_level,
      'doc_type': doc_type.sub('书',''),
      'content': origin_content
  }

  response = Net::HTTP.post_form(url,data)
  res = JSON.parse response.body
  if res['code'].to_i == 200
    aFile = File.open("error","a+")
    aFile.syswrite("#{res['data']}\n")
  else
    error_array = error_array << id_no
    puts id_no
  end
end
puts "错误的个数：#{error_array.length}"
puts error_array
