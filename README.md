**利用Harbor Api处理镜像**：[参考链接](https://www.cnblogs.com/guigujun/p/8352983.html "参考链接")

* 获取项目信息：curl -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/projects/2" 2是项目ID
* 获取所有项目信息：curl -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/projects?"
* 搜索镜像：curl  -u "admin:Harbor12345"  -X GET -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/search?q=centos"
* 删除项目：curl  -u "admin:Harbor12345"  -X DELETE  -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/projects/3"
* 创建项目：curl -u "admin:Harbor12345" -X POST -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/projects" -d @createproject.json createproject.json为文件名，文件内容参考createproject.json
* 创建用户：curl -u "admin:Harbor12345" -X POST -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/users" -d @user.json
* 获取用户信息：curl -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/users" 除admin外
* 查看当前用户信息：curl -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/users/current"
* 删除用户：curl -u "admin:Harbor12345" -X DELETE  -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/users/3"
* 修改用户密码：curl -u "admin:Harbor12345" -X PUT -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/users/4/password" -d @uppwd.json
* 查看项目相关角色：curl -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/projects/2/members/"
* 项目添加角色：curl -u "jaymarco:Harbor123456" -X POST  -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/projects/2/members/" -d @role.json
* 查看镜像：curl -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/repositories?project_id=2&q=centos%2Fcentos" 比如项目下数量
* 删除镜像：curl -u "admin:Harbor12345" -X DELETE -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/repositories/testrepo%2Fcentos/tags/镜像标签"
* 获取镜像标签：curl -s  -u "admin:Harbor12345" -X GET -H "Content-Type: application/json" "https://zhouhua.zaizai.com/api/repositories/testrepo%2Fcentos/tags/" |grep "\"name\"" |awk -F"\\"" '{print $4}'

