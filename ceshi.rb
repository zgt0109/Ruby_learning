#!/usr/bin/ruby
# coding: utf-8
require 'pry'
require 'pp'
require 'json'
require 'net/http'
require 'uri'

# http://www.looklaw.cn/doc/e12848ce5d9f197ddc327819ddeeadf4
id_no = ARGV[0]
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

pp resp

# pp origin_content
puts '*'*150
# 调用本地接口测试
url = URI.parse('http://localhost:3000/looklaw')

if case_type == '执行案件'
  judge_level = ''
end

data = {
    'case_type': case_type.sub('案件',''),
    'judge_level': judge_level,
    'doc_type': doc_type.sub('书',''),
    'content': origin_content
}
begin
  response = Net::HTTP.post_form(url,data)
  # binding.pry
  res = JSON.parse response.body
  pp res
rescue
  puts id_no
end
