#!/bin/bash
###选择项目
projects=`curl -s -u "admin:test" -X GET -H "Content-Type: application/json" "https://harbor.limin.com/api/projects?" |grep "\"name\""|awk -F "\"" '{print $4}'`
select i in $projects;
do
project=$i
break;
done
####获取项目对应的project_id值
project_id=`curl -s -u "admin:test" -X GET -H "Content-Type: application/json" "https://harbor.limin.com/api/projects?" |grep "$project" -C 2 |grep "project_id" |awk '{print $2}'|awk -F "," '{print$1}'`

###通过project_id值获取镜像仓库名称
cangku=`curl -s -u "admin:test" -X GET -H "Content-Type: application/json" "https://harbor.limin.com/api/repositories?project_id=$project_id" |grep "$projects"|awk -F "\"" '{print$2}'|awk -F '/' '{print$2}'`

########获取镜像名称

select i in $cangku
do 
image=$i
break;
done
echo $image
######获取版本号
version=`curl -s -u "admin:test" -X GET -H "Content-Type: application/json" "https://harbor.limin.com/api/repositories/$project%2F$image/tags/" | awk -F "\"" '{print$2}'`
echo $version
####根据版本号删除镜像
while [ 1 ];
do 
  echo -e "退出请输入\033[33m exit \033[0m，请输入标签号: "
  read -p "" number
if [ $number == exit ];
then
  exit
else
  echo "$number"
curl -u "admin:test" -X DELETE -H "Content-Type: application/json" "https://harbor.limin.com/api/repositories/$project%2F$image/tags/$number"
fi
done
exit

