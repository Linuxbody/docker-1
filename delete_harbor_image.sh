#! /bin/bash
# 通过Harbor提供的API来批量删除镜像，人工删除费时费力
# 经过测试发现，通过接口去删除时提供的是的标签，但实际上删除的时候通过的是镜像的IMAGE_ID,也就是说
# 如果我把同一个镜像tag多次上传到harbor，通过借口删除时，只需要提供其中一个标签，那么和这个镜像的IMAGE_ID相同的镜像都会删除


#### 项目个数
lines=`curl -s -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://harbor.k8stest.com/api/projects?" |grep "\"name\""|awk -F "\"" '{print $4}'|wc -l`
##### 展示当前有几个项目
echo "当前Harbor有以下几个项目:"
for i in $(seq 1 $lines)
do
   ###########具体是啥项目
   a=`curl -s -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://harbor.k8stest.com/api/projects?" |grep "\"name\""|awk -F "\"" '{print $4}'|awk -v b=$i 'NR==b{print $1}'`
   echo $i、$a
done
#######选择具体的项目
read -p  "请输入序号(1~$lines):,查看其下的镜像仓库:" number
if [ $number -ge 1 -a $number -le $lines ]
then
 #########选择的是哪个项目
 c=`curl -s -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://harbor.k8stest.com/api/projects?" |grep "\"name\""|awk -F "\"" '{print $4}'|awk -v b=$number 'NR==b{print $1}'`
#####多少个仓库
 # d=`curl -s -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://harbor.k8stest.com/api/projects?" |grep "$c" -C 2 |grep "project_id" |awk '{print $2}' |awk -F "," '{print $1}'`
  #echo "\$d-----------$d"
######显示仓库个数
 ## e=`curl -s -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://harbor.k8stest.com/api/repositories?project_id=$d" | grep "\"name\"" |awk -F "\"" '{print $4}' |awk -F "/" '{print $2}'|wc -l`
e=`curl -s -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://harbor.k8stest.com/api/repositories?project_id=2" | grep "\"name\"" |awk -F "\"" '{print $4}' |sed 's/sc\///g'|wc -l`
 ####### 简单展示
  echo "项目$c下有以下镜像仓库："
  for line in $(seq 1 $e)
  do
   #####具体的仓库名
    f=`curl -s -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://harbor.k8stest.com/api/repositories?project_id=$d" | grep "\"name\"" |awk -F "\"" '{print $4}' |sed 's/sc\///g'|awk -v g=$line 'NR==g{print $1}'`
    echo $line、$f
  done
   read -p  "请输入序号(1~$e):,查看其下的镜像格式以及对应的数量:" num
   if [ $num -ge 1 -a $num -le $e ]
   then
  #### 镜像仓库名字
     h=`curl -s -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://harbor.k8stest.com/api/repositories?project_id=$d" | grep "\"name\"" |awk -F "\"" '{print $4}' |sed 's/sc\///g'|awk -v g=$num 'NR==g{print $1}'`
     echo "您选择的仓库是$h"
  #### 标签类型种类个数
#     i=`curl -s -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://harbor.k8stest.com/api/repositories/$c%2F$h/tags/" |grep "\"name\"" |awk -F"\"" '{print $4}' | cut -c -6 |sort -n |uniq|wc -l`
    # echo $i
 #### 标签类型以及个数
    echo "##################################"
    echo "镜像格式为：如果是10月，则为201810*"
    echo "##################################"
    #####每种镜像格式以及其数量
    curl -s -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://harbor.k8stest.com/api/repositories/$c%2F$h/tags/" |grep "\"name\"" |awk -F"\"" '{print $4}' | cut -c -6 |awk '{count[$1]++}END{for (i in count)print i,count[i]}'
 ######输入镜像格式，进行删除
     echo "如果想删除某种形式的镜像,请输入类型："
     read image_format
     ##########输入类型的所有镜像
     images=`curl -s -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://harbor.k8stest.com/api/repositories/$c%2F$h/tags/" |grep "\"name\"" |awk -F"\"" '{print $4}'|grep $image_format|awk '{print $1}'`
     #########统计镜像个数
    count_image=`curl -s -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://harbor.k8stest.com/api/repositories/$c%2F$h/tags/" |grep "\"name\"" |awk -F"\"" '{print $4}'|grep $image_format|wc -l`
    for image_label in $images
    do
    #############执行删除
      curl -u "admin:Harbor12345" -X DELETE -H "Content-Type: application/json" "https://harbor.k8stest.com/api/repositories/$c%2F$h/tags/$image_label"
    done
      if [ $? -eq 0 ]
      then
        echo "删除成功"
        echo "本次共删除$count_image个镜像"
      fi
 fi
fi
