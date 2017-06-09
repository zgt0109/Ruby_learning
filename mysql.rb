#!/usr/bin/ruby -w
require 'mysql2'
require 'pp'

client = Mysql2::Client.new(
    :host     => '127.0.0.1', # 主机
    :username => 'root',      # 用户名
    :password => '123456',    # 密码
    :database => 'shanghai_development',      # 数据库
    :encoding => 'utf8'       # 编码
    )
results = client.query("SELECT VERSION()")
results.each do |row|
  pp row
end

rs = client.query("select * from books;")
rs.each do |row|
  pp row
end
