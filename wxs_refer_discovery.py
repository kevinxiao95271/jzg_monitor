#!/usr/bin/env python 
import os
import simplejson as json
t=os.popen("""sudo grep -E  "/app/wxs/|MiniProgram" /services/data/logs/nginx/jzg-api-backup.log   | awk -F ' ' '{print $12 }' | grep http | sed 's/.$//' | awk '{print substr($1,2)}' | sed 's/https:\/\///' | sort -rn | uniq -c | sort -rn | head -15  | awk -F ' ' '{print $2 }' """)
refer_name = []
for refer in  t.readlines():
    r = refer.strip()
    refer_name += [{'{#REFERNAME}':r}]
print json.dumps({'data':refer_name},sort_keys=True,indent=4,separators=(',',':'))
