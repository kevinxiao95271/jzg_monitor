#!/usr/bin/env bash
# -----------------------------------
# -----------------------------------

[ ! -d /tmp/nginx ] && mkdir /tmp/nginx
LOG_PATH=/services/data/logs/nginx/jzg-api-backup.log   #Nginx日志路径
LOG_TEMP=/tmp/nginx/nginx_last_min.log                  #Nginx上一分钟文件
LOG_STAT=/tmp/nginx/nginx_stat.txt                      #Nginx状态码文件
LAST_MIN1=`date -d "5 minute ago" +%Y:%H:%M`             #获取上一分钟值
LAST_MIN2=`date -d "6 minute ago" +%Y:%H:%M`             #获取上一分钟值
LAST_MIN3=`date -d "7 minute ago" +%Y:%H:%M`             #获取上一分钟值
LAST_MIN4=`date -d "8 minute ago" +%Y:%H:%M`             #获取上一分钟值
LAST_MIN5=`date -d "9 minute ago" +%Y:%H:%M`             #获取上一分钟值
LAST_MIN6=`date -d "10 minute ago" +%Y:%H:%M`             #获取上一分钟值
LAST_MIN7=`date -d "11 minute ago" +%Y:%H:%M`             #获取上一分钟值
LAST_MIN8=`date -d "12 minute ago" +%Y:%H:%M`             #获取上一分钟值
LAST_MIN9=`date -d "13 minute ago" +%Y:%H:%M`             #获取上一分钟值
LAST_MIN10=`date -d "14 minute ago" +%Y:%H:%M`             #获取上一分钟值
#LAST_MIN_ORIG=`date -d "15 minute ago" +%Y:%H:%M`             #获取上一分钟值
#LAST_MIN=${LAST_MIN_ORIG%?}

tail -150000 ${LOG_PATH} | grep -E "${LAST_MIN1}|{LAST_MIN2}|{LAST_MIN3}|{LAST_MIN4}|${LAST_MIN5}${LAST_MIN6}|{LAST_MIN7}|{LAST_MIN8}|{LAST_MIN9}|${LAST_MIN10}" > ${LOG_TEMP}
#tail 3万行数据然后进行过滤上一分钟，如果请求量较大则加大行数，过滤后将数据重定
向到上一分钟文件中
cat ${LOG_TEMP} | awk -F ' ' '{print $10}' | sort | uniq -c | sort -rn > ${LOG_STAT}   #过滤上一分钟文件的状态码并对状态码进行排序去重然后显示状态码次数

#200 Code
#过滤临时文件中状态码等于200的值然后打印其次数后赋值给c_200，然后重定向到/tmp/nginx/nginx_200.txt,如果其值为空，则赋值为0后重定向到/tmp/nginx/nginx_200.txt
c_200=`cat ${LOG_STAT} | awk '$2==200{print $1}'`;[ -z ${c_200} ] && c_200=0;echo ${c_200} > /tmp/nginx/nginx_200.txt
c_202=`cat ${LOG_STAT} | awk '$2==202{print $1}'`;[ -z ${c_202} ] && c_202=0;echo ${c_202} > /tmp/nginx/nginx_202.txt

#300 Code
c_301=`cat ${LOG_STAT} | awk '$2==301{print $1}'`;[ -z ${c_301} ] && c_301=0;echo ${c_301} > /tmp/nginx/nginx_301.txt
c_302=`cat ${LOG_STAT} | awk '$2==302{print $1}'`;[ -z ${c_302} ] && c_302=0;echo ${c_302} > /tmp/nginx/nginx_302.txt
c_304=`cat ${LOG_STAT} | awk '$2==304{print $1}'`;[ -z ${c_304} ] && c_304=0;echo ${c_304} > /tmp/nginx/nginx_304.txt

#400 Code
c_400=`cat ${LOG_STAT} | awk '$2==400{print $1}'`;[ -z ${c_400} ] && c_400=0;echo ${c_400} > /tmp/nginx/nginx_400.txt
c_403=`cat ${LOG_STAT} | awk '$2==403{print $1}'`;[ -z ${c_403} ] && c_403=0;echo ${c_403} > /tmp/nginx/nginx_403.txt
c_404=`cat ${LOG_STAT} | awk '$2==404{print $1}'`;[ -z ${c_404} ] && c_404=0;echo ${c_404} > /tmp/nginx/nginx_404.txt
c_405=`cat ${LOG_STAT} | awk '$2==405{print $1}'`;[ -z ${c_405} ] && c_405=0;echo ${c_405} > /tmp/nginx/nginx_405.txt

#500 Code
c_502=`cat ${LOG_STAT} | awk '$2==502{print $1}'`;[ -z ${c_502} ] && c_502=0;echo ${c_502} > /tmp/nginx/nginx_502.txt
c_503=`cat ${LOG_STAT} | awk '$2==503{print $1}'`;[ -z ${c_503} ] && c_503=0;echo ${c_503} > /tmp/nginx/nginx_503.txt
c_504=`cat ${LOG_STAT} | awk '$2==504{print $1}'`;[ -z ${c_504} ] && c_504=0;echo ${c_504} > /tmp/nginx/nginx_504.txt

#以下来定义函数方便 UserParameter 调用
function c_200 {
        cat /tmp/nginx/nginx_200.txt
}

function c_202 {
        cat /tmp/nginx/nginx_202.txt
}

function c_301 {
        cat /tmp/nginx/nginx_301.txt
}

function c_302 {
        cat /tmp/nginx/nginx_302.txt
}

function c_304 {
        cat /tmp/nginx/nginx_304.txt
}

function c_400 {
        cat /tmp/nginx/nginx_400.txt
}

function c_403 {
        cat /tmp/nginx/nginx_403.txt
}

function c_404 {
        cat /tmp/nginx/nginx_404.txt
}

function c_405 {
        cat /tmp/nginx/nginx_405.txt
}

function c_502 {
        cat /tmp/nginx/nginx_502.txt
}

function c_503 {
        cat /tmp/nginx/nginx_503.txt
}

function c_504 {
        cat /tmp/nginx/nginx_504.txt
}
function mini_wx {
        grep -E "/app/wxs/|MiniProgram" /services/data/logs/nginx/jzg-api-backup.log | wc -l
}
$1
