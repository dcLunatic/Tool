机房屏幕的监控的一些工具及破解思路
===================
工具有空会上传


当老师还没有控制的时候，打开工具，破解即可
如果来不及打开工具，可以考虑拔掉网线，会卡出来，（但有可能也会很卡），此时打开工具即可
或者在再次插入网线，连接时，会有一小会的连接时间，自己看着办吧。


### 幻影云
-  [软件公司](http://www.phantosys.net/)
-  [参与大学列表](http://www.phantosys.net/hyy/cgal_jy.html)
- 极域也是可以的。
### 键盘拦截测试
![测试图片](https://github.com/dcLunatic/Tool/blob/master/computeRoom/keyboardTest.png)

### 广东金融学院
- 幻影云版本:
  > PhantosysCloud v5.0 2014 standard
- 设置解锁密码:
  > 87053276  
  可使用动态调试工具跟踪即可获得该密码，注册表中找密码的方式已废（加密过的）
  
  
### 简单破解思路（☆☆☆☆☆）
- 将进程StudentMain.exe进程关闭即可
- 任务管理器->资源监视器(也可已直接使用resmon打开)->找到StudentMain.exe->右键，挂起即可
    - 也可以使用程序实现（SuspendThread(HANDLE) ResumeThread(HANDLE))


### 初级破解思路（★★☆☆☆）
- 将屏幕广播窗口中的*全屏按钮*设置为有效即可
    - 注：这里没有使用自绘按钮，只需遍历当前进程的所有子窗口，找到Button类控件窗口，有效即可
- 部分键盘按钮被拦截
    - 可以自行写一个dll文件，hook按钮操作(级别应该要很低不然无用)，然后再将对应的那些按键消息投递出来即可。    
    - 开新线程循环挂钩也可。    
    - 动态调试该程序，找到hook相关位置，然后自行编写dll，注入到StudentMain.exe进程，做相关处理即可   
> 注:广东金融学院机房电脑运行环境比较低，推荐使用vs2013及以下版本的编写动态链接库文件，不然无法正常加载（虽然可修复）
    
### 高级破解思路（★★★★★）
1. 教师段操作，然后学生端这边动态调试，跟踪后，修改对应的反汇编代码，最后保存即可。

> 可使用函数参考，从函数名称可以很明显猜到对应的功能。如:InitHook RegisterHotKey RegisterCtrlHotKey LockLocalInput等等

2. 教师段操作，然后学生端这边抓包，分析后，自行处理再让程序接收。

*如果没有多台电脑，可使用虚拟机代替。只要处于同一网段下即可。*

**由于学生端只包含学生端功能，考虑如何做出类似于教师段的功能。**

前提：一台电脑装学生端，一台电脑装教师端。
#### 教师端操作，然后在学生端这边，使用抓包工具，如WireShark等，抓取分析后处理即可。
然后，基于抓包分析，分析出教师端ip地址mac地址通讯port等信息，然后模仿教师端发送数据包给其他的学生端，模拟教师端功能。
这里推荐一篇[博客](http://blog.csdn.net/envon123/article/details/9245831)以供参考


> 注入打开进程的时候，考虑使用ZwOpenProcessAPI，而不是使用OpenProcessAPI，因为这个已被拦截。
当然，如果你对免杀有一定了解，还有更加丰富的手段来达到目的。

> 对于保存相关文件的文件夹，在初次启动时未有任何保护，可以自行修改其中内容，而在连接教师机后，StudentMain.exe会将该文件夹设下权限，如果此时对某些文件进行修改替换，会出现权限不够的问题。 有兴趣的可自行了结Windows下的ACL表，笔者稍微调试过，但没深入。这里推荐一篇[文章](http://blog.csdn.net/lazyclough/article/details/6841828)。Windows下的[cacls](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc732245(v=ws.11))命令也可以用来设置。

> 至于广东金融学院的我取巧了
- 目标文件夹：C:\Program Files (x86)\Phantosys\PhantosysCloud v5.0 2014 standard\
- 关键dll文件：libTDMaster.dll(与键盘hook相关)
- 相关进程：StudentMain.exe PhantosysClientService.exe MasterHelper.exe
- 方法：依次结束以上进程(StudentMain.exe有时可以不用),然后删除libTDMaster.dll文件，在copy破解后的dll进去即可。


