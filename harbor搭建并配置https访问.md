# harbor搭建并使用https访问
> 依赖环境：  
> docker版本 Docker version 18.06.1-ce  
>docker-compose版本 docker-compose version 1.22.0

**可参考**：https://www.58jb.com/html/117.html

## 安装docker
### 1.安装依赖包
```
yum install -y yum-utils device-mapper-persistent-data lvm2
```
### 2.添加国内yum源
```
yum-config-manager --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo
```
### 3.更新yum软件源缓存，并安装docker-ce
```
yum makecache fast && yum install docker-ce
```
### 4.设置镜像加速器

在/etc/docker/daemon.json中写入如下内容
```
{
 "registry-mirrors": [
     "https://registry.docker-cn.com"
   ]
}
```
阿里云镜像加速器地址 
```
https://cr.console.aliyun.com/cn-hangzhou/mirrors
```

### 5.启动docker服务

```
systemctl start docker
```

## 安装docker-compose
### 1.下载指定版本docker-compose

```
curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

### 2.对二进制文件赋予可执行权限

```
chmod +x /usr/local/bin/docker-compose
```

### 3.查看docker-compose版本

```
docker-compose --version
```

## 安装harbor服务
### 1.下载离线安装包并解压

```
wget https://github.com/vmware/harbor/releases/download/v1.1.2/harbor-offline-installer-v1.1.2.tgz
tar xvf harbor-offline-installer-v1.1.2.tgz
```


### 2.配置harbor使用https访问

- 修改配置文件  
vim harbor.cfg

```
hostname elastic   #将hostname修改成自己的主机名或者ip
ui_url_protocol = https      #设置使用https协议访问
```

- 生成证书

```
openssl req -newkey rsa:2048 -nodes -sha256 -keyout /data/cert/server.key -x509 -days 365 -out /data/cert/server.crt  
#证书存放目录要和harbor.cfg文件里的配置相同
或者使用下面这种来签署证书：
openssl req -nodes -subj "/C=CN/ST=ChongQing/L=QianJiang/CN=zhouhua.zaizai.com" -newkey rsa:2048 -keyout zhouhua.zaizai.com.key -out zhouhua.zaizai.com.csr
openssl x509 -req -days 3650 -in zhouhua.zaizai.com.csr -signkey zhouhua.zaizai.com.key -out zhouhua.zaizai.com.crt 
openssl x509 -req -in zhouhua.zaizai.com.csr -CA zhouhua.zaizai.com.crt -CAkey zhouhua.zaizai.com.key -CAcreateserial -out zhouhua.zaizai.com.crt -days 10000 
```
- 为harbor生成配置文件  
./prepare  
- 安装harbor  
./install.sh      
- 访问harbor  
在终端输入docker login elastic 或者在浏览器输入https://yourself ip都可以访问


### 测试在harbor服务器登陆 我这里使用的是zhouhua.zaizai.com作为证书名字
```
[root@ansible-k8s1 zhouhua.zaizai.com]# docker login zhouhua.zaizai.com
Username (admin): admin
Password:
Error response from daemon: Get https://zhouhua.zaizai.com/v2/: x509: certificate signed by unknown authority

解决:  cp zhouhua.zaizai.com.crt /etc/docker/certs.d/zhouhua.zaizai.com/ca.crt 再次登陆就可以了

```

### 注意事项

+ 在打包镜像后，如果需要push到harbor，需要先去harborUI上创建项目，比如centos，打包的镜像为zhouhua.zaizai.com/centos/centos:20181018，然后push
+ 一定要做这一步：cp zhouhua.zaizai.com.crt /etc/docker/certs.d/zhouhua.zaizai.com/ca.crt
+ 其他服务器需要从harbor服务器pull镜像，/usr/lib/systemd/system/docker.service添加--insecure-registry zhouhua.zaizai.com(centos7这样做)
