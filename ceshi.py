# -*- coding:utf-8 -*-

import requests
import pprint
import json
import re
import sys

# try:
#     ndoc_id =sys.argv[2]
#     url = 'http://www.looklaw.cn/docdemo/structor?anyou_code=00100500'+sys.argv[1]+'&id_no='+ndoc_id
# except:
#     ndoc_id = ""
#     url = 'http://www.looklaw.cn/docdemo/structor?anyou_code=00100500' + sys.argv[1]

# try:
#     ndoc_id =sys.argv[1]
#     url = 'http://www.looklaw.cn/docdemo/structor?anyou_code=001004009&id_no='+sys.argv[1]
# except:
#     url = 'http://www.looklaw.cn/docdemo/structor?anyou_code=001004009'


#url = "http://www.looklaw.cn/docdemo/structor?anyou_code=001006001020"
# url = "http://www.looklaw.cn/docdemo/structor?anyou_code=001005002&id_no=cfd66deb6f085d8430526394c6fc4683"
#url = "http://www.looklaw.cn/docdemo/structor?anyou_code=001004003"
# url = "http://www.looklaw.cn/docdemo/structor?anyou_code=001004009"

doc_id =sys.argv[1]
url = "http://www.looklaw.cn/docdemo/structor?id_no="+sys.argv[1]
# 22af7e0a1fe01d49b67d74ab5686ee3c
pp = pprint.PrettyPrinter(indent=2)
response = requests.get(url)
res = response.json()
resp = res[0]
case_num = resp['case_num']
id_no = resp['id_no']
doc_id = resp['id_no' ]
case_type = resp['case_type']
anyou_code = resp['anyou_code']
anyou_name = resp['anyou_name']
fayuan_name = resp['fayuan_name']
origin_content = resp['origin_content']
fayuan_renwei = resp['fayuan_renwei']
print("")
print("")
print("")
print(fayuan_renwei)
print("")
print("")
print("")
print(id_no)
print("")
print("")
print("")
print(origin_content)

case_url = 'http://127.0.0.1:3000/index.php'
data = {
    'case_num': case_num,
    'doc_id': doc_id,
    'case_type': case_type,
    'anyou_code': anyou_code,
    'anyou_name': anyou_name,
    'fayuan_name': fayuan_name,
    'origin_content': origin_content
}
html = requests.post(case_url, data=data)
print(html.text)
pp.pprint(html.json())
