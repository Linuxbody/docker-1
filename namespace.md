### namespace 目的是实现轻量级虚拟化(容器)服务

namespace|系统调用参数|隔离内容
-|-|-
UTS|CLONE_NEWUTS|主机名与域名
IPC|CLONE_NEWIPC|信号量、消息队列和共享内存
PID|CLONE_NEWPID|进程编号
Network|CLONE_NEWNET|网络设备、网络线、端口等
Mount|CLONE_NEWS|挂载点(文件系统)
User|CLONE_NEWUSER|用户和用户组

namespace的API包括clone()  setns() unshare() /proc下的部分文件

* 通过clone()在创建新进程的同时创建namespace
* 查看/proc/[pid]/ns文件
* 通过unshare()在原先进程上进行namespace隔离
* fork()系统调用

