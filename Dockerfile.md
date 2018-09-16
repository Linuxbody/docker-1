#关于Dockerfile的命令使用，以及某些命令的差别和如何利用Dockerfile制作镜像
# 编写好Dockerfile后，执行docker build 用户/仓库:标签 .


全文参考：https://www.cnblogs.com/dazhoushuoceshi/p/7066041.html

FROM image_name # 基础镜像，基于一个基础镜像制作自己想要的镜像，先从本地找，如果找不到就到你说指定的仓库中去找

环境变量的引用 ${NAME:-tom}:如果tom有值，就使用值，不然就使用tom
              ${NAME:+tom}:如果tom有值，就使用tom，不然就使用值
#利用#号添加注释

MAINTAINER #制作者详细信息 test test@test.com

LABEL #为镜像赋予标签，可以添加一些信息，k/v形式

COPY # 用于从Docker主机复制文件到镜像中
如果src是目录，则其内部文件或者子目录将会被复制，目录本身不会被复制
# COPY index.html /data/nginx/www/html/ 文件须与Dockerfile在同一目录
# COPY yum.repos.d /etc/yum.repos.d   复制目录src下的所有文件到目标目录


ADD  # 与COPY不同的是ADD 可以添加url，如果src在本地是一个压缩包，则ADD可以自动展开；如果是一个url的压缩包，则不会自动展开。

WORKDIR 指定工作目录
USER 指定容器启动时的用户
EXPOSE 暴露端口 一次可以指定多个端口
VOLUME 卷
ENTRYPOINT 容器启动时需要启动的命令
与CMD比较说明（这俩命令太像了，而且还可以配合使用）：

1. 相同点：

只能写一条，如果写了多条，那么只有最后一条生效

容器启动时才运行，运行时机相同

 

2. 不同点：

 ENTRYPOINT不会被运行的command覆盖，而CMD则会被覆盖

 如果我们在Dockerfile种同时写了ENTRYPOINT和CMD，并且CMD指令不是一个完整的可执行命令，那么CMD指定的内容将会作为ENTRYPOINT的参数

如下：

FROM ubuntu
ENTRYPOINT ["top", "-b"]
CMD ["-c"]
如果我们在Dockerfile种同时写了ENTRYPOINT和CMD，并且CMD是一个完整的指令，那么它们两个会互相覆盖，谁在最后谁生效

如下：

FROM ubuntu
ENTRYPOINT ["top", "-b"]
CMD ls -al
那么将执行ls -al ,top -b不会执行



ENV 设置环境变量
CMD 容器启动时需要执行的命令

RUN 执行命令生成一个镜像层，如果有多个一样的可使用&&,有多个参数可使用\



