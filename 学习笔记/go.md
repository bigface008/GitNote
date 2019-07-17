# Go 学习笔记

## Tips

### 1. 尴尬的Go语言支持工具链安装Bug

像`gocode`、`guru`、`gorename`这种东西貌似不是包括在Google官方工具包里面的（TODO:有待考证），所以VScode里面安装Go插件之后会提示要再装一下，不然补全之类的功能会很残废。不过，你让他自己装可能会出现下面这种输出

    Installing github.com/golang/lint/golint FAILED

    Installing github.com/cweill/gotests/... FAILED
    Installing github.com/derekparker/delve/cmd/dlv SUCCEEDED
    8 tools failed to install.
    go-outline:
    Error: Command failed: D:\Go\bin\go.exe get -u -v github.com/ramya-rao-a/go-outline
    github.com/ramya-rao-a/go-outline (download)
    Fetching https://golang.org/x/tools/go/buildutil?go-get=1
    https fetch failed: Get https://golang.org/x/tools/go/buildutil?go-get=1: dial tcp 216.239.37.1:443: connectex: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond.

这貌似并不是科学上网就能解决的。[这篇帖子](https://zhuanlan.zhihu.com/p/56567884)里面说国际友人也会遇到[这种问题](https://github.com/Microsoft/vscode-go/issues/2142)。解决方案如下。（用于Windows）

```shell
mkdir -p $env:GOPATH/src/golang.org/x/
cd $env:GOPATH/src/golang.org/x/
git clone https://github.com/golang/tools.git
```

~~之后就可以正常安装了。目前没心情去搞清楚原理（TODO:有待补完），不过我猜应该是缺了安装用的工具，而VScode的Go插件并不会检查并安装这个工具。~~

之后又炸了。其他工具正常，golint出了问题，最后按照[这个文档](https://gist.github.com/try876/8a98f68f77f4f9eb03fde6ba95adcad4)做，成功解决。

```shell
cd $env:GOPATH
git clone https://github.com/golang/lint.git
go get golang.org/x/lint/golint
```

注意上面装tools的步骤也是需要的。

TODO:这个问题果然还是很让人在意:expressionless:

#### [失败原因](https://zhuanlan.zhihu.com/p/53566172)

> 原因其实很简单：golang.org 在国内由于一些 众所周知的 原因无法直接访问，而go get在获取gocode、go-def、golint等插件依赖工具的源码时，需要从 golang.org 上拉取部分代码至GOPATH，自然就导致了最后这些依赖于 golang.org 代码的依赖工具安装失败。

### 2. Go声明变量

```go
var nmd, wsm string = "U", "SB"
var nmd, wsm = "U", "SB"
nmd, wsm := "U", "SB"
```

### 3. for语句的特点

1. `{}`是必须要有的。

```go
for i := 0; i < 10; i++ {
	sum += i
}
```

2. 不知道为啥，`i := 0`这东西是不可以写成有`var`的形式的。`go build`会报错。

3. 初始化变量和累加的部分是可以省略的。

```go
sum := 1
for ; sum < 1000; {
	sum += sum
}
```