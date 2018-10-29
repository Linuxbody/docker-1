**利用Harbor Api处理镜像**

* 获取项目信息：curl -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/projects/2" 2是项目ID
* 获取所有项目信息：curl -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/projects?"
* 搜索镜像：curl  -u "admin:Harbor12345"  -X GET -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/search?q=centos"
* 删除项目：curl  -u "admin:Harbor12345"  -X DELETE  -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/projects/3"
* 创建项目：curl -u "admin:Harbor12345" -X POST -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/projects" -d @createproject.json createproject.json为文件名，文件内容参考createproject.json
* 创建用户：curl -u "admin:Harbor12345" -X POST -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/users" -d @user.json

