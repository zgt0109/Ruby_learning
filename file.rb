#!/usr/bin/ruby
# coding: utf-8
require 'pry'
require 'pp'
require 'json'
require 'net/http'
require 'uri'

lines = File.readlines('错误的检察院_1.csv')

aFile = File.new("error1","a+")
aFile.syswrite("检察院名字|检察院角色|案号|内容\n")
lines.each_with_index do |value,index|
  # binding.pry
  id_no = value.scan(/\"(.*)\",/).join

  # http://www.looklaw.cn/doc/e12848ce5d9f197ddc327819ddeeadf4
  # id_no = ARGV[0]
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

  bd = origin_content.gsub(/\n/, '').gsub(/\s/, '')
  rege = bd.scan(/(style.*?)>/).flatten
  rege.each do |r|
    bd.sub!(r, '')
  end
  div = bd.scan(/<div >.*?<BODY><\/div>/).join
  unless div.empty?
   bd.sub!(div, '').sub!("<div ></BODY></html></div>", "")
  end
  # 去除div样式
  bd = bd.gsub(/&times;/,'×').gsub(/&middot;/,'·').gsub(/&bull;/,'•')
  bd = bd.gsub('?', '？').gsub(',', '，').gsub('：', ':').gsub('.', '。').gsub('(', '（').gsub(')', '）')
  bd = bd.gsub(/<div(.*?)>/, '<').gsub(/<\/div>/, '>').gsub(/<\/div/, '>')
  bd = bd.gsub(/<atype.*?><\/a>/, '').gsub('　','').gsub('\t','')
  bd = bd.gsub(/<style.*?><\/a>/, '')
#   去除p、span、h1标签
  bd = bd.gsub('<<p>>','').gsub('</p>','').gsub('<p>','')
  bd = bd.gsub(/<p.*?>/,'').gsub(/<span.*?>/,'')
  bd = bd.gsub(/<!DOC.*?>/i,'').gsub(/<meta.*?>/i,'').gsub(/<!--TABLE.*?>/i,'').gsub(/<HTML.*?>/i,'')
  bd = bd.gsub(/<\/?HTML>/i,'').gsub(/<HEAD>/i,'').gsub(/<\/?TITLE>/i,'').gsub(/<\/?BODY>/i,'')
  bd = bd.gsub('<br/>','').gsub(/\\/,'')
  bd = bd.gsub(/<"width.*?>/,'').gsub(/<"height.*?>/,'')
  bd = bd.gsub(/<object.*?>/,'').gsub(/<embed.*?>/,'')

  bd = bd.gsub('<b>','').gsub('</b>','')
  bd = bd.gsub('<span>','').gsub('</span>','')
  bd = bd.gsub('<title>','').gsub('</title>','')
  bd = bd.gsub('<strong>','').gsub('</strong>','')
  bd = bd.gsub(/<h\d{1,2}>/,'').gsub(/<\/h\d{1,2}>/,'')
  bd = bd.gsub(/<imgsrc.*?>/,'')
  bd = bd.gsub(/align.*?>/,'')
  bd = bd.gsub(/<ahref.*?>/,'').gsub('</a>','').gsub('<a>','')
  bd = bd.gsub(/<table.*?>/,'').gsub('</table>','')
  bd = bd.gsub(/<tbody>/,'').gsub('</tbody>','')
  bd = bd.gsub(/<tr.*?>/,'').gsub('</tr>','')
  bd = bd.gsub(/<td.*?>>/,'').gsub('</td>','')
  bd = bd.gsub('﹤strike﹥','').gsub('﹤／strike﹥','')
  bd = bd.gsub('﹤STRIKE﹥','').gsub('﹤／STRIKE﹥','')
#   <Ahref='。。/。。/。。/安排表。doc'>一</A>
  bd = bd.gsub(/<Ahref=.*?>/,'').gsub(/<\/A>/,'')
  bd = bd.gsub(/诉讼代表人＊{1,3}[，。；]/,'诉讼代表人张某＊，')
  # <仿宋
  bd = bd.gsub(/<仿宋.*?>/,'').gsub(/<宋体.*?>/,'').gsub(/<日期.*?>/,'').gsub(/<正文.*?>/,'')
  bd = bd.gsub(/<纯文本.*?>/,'').gsub(/<普通.*?>/,'').gsub(/<页眉.*?>/,'').gsub(/<标题.*?>/,'')
  bd = bd.gsub(/<窗体.*?>/,'').gsub(/<（'temp.*?>/,'').gsub(/<网格.*?>/,'').gsub(/<浅色.*?>/,'')
  bd = bd.gsub(/<中等.*?>/,'').gsub(/<[#%@].*?>/,'').gsub(/normal'/i,'').gsub(/mso.*?>/i,'')
  # binding.pry
  bd = bd.gsub('<o:p></o:>','>').gsub(/'TimesNewRoman''>/i,'')
  bd = bd.gsub('<>','').gsub('</>','').gsub('<<','<').gsub('>>','>')

  pp id_no
  puts '*'*100
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
    aFile = File.open("error1","a+")
    aFile.syswrite("#{res['data']['jiancha_name']}|#{res['data']['jiancha_role']}\n")
    aFile.syswrite("#{id_no}\n")
    aFile.syswrite("#{bd[0,200]}\n\n")
  else
    puts id_no
  end
end
puts "总个数：#{lines.size}"
