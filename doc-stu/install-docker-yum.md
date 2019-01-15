```
1. remove old version: yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
# yum-utils 提供Yum-config-manager 其他两个被存储驱动所依赖            
2.install required package: yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
3.add yum repo: yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

4.optional: yum-config-manager --enable docker-ce-edge

5.install docker-ce: yum install docker-ce

6.install 特定版本 查找: yum list/search docker-ce --showduplicates |sort -r
                  安装: yum install docker-ce-<VERSION STRING>
7.启动docker: systemctl start docker && systemctl enable docker


```