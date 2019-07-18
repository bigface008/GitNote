# Go 学习笔记

## Tips

### 1. Bug of Installing Tool Chains For Go

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

### 2. Declaration of Variables

```go
var nmd, wsm string = "U", "SB"
var nmd, wsm = "U", "SB"
nmd, wsm := "U", "SB"
```

### 3. `for`

1. `{}`是必须要有的。`()`是不需要的。

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

4. go里面貌似是没有`while`的，直接用`for`来代替。

   ```go
   sum := 1
   for sum < 1000 {
       sum += sum
   }
   ```

5. 这个东西就是个`while true`循环。

   ```go
   for {
   }
   ```

### 4. `if`

1. `{}`也是不能省略的。`()`也是不需要的。

2. `if`语句可以以一个赋值语句开始。不过这个值只在`if`语句内部才有用。

   ```go
   if v := math.Pow(x, n); v < lim {
       return v
   }
   ```

### 5. `switch`

1. > Go's switch is like the one in C, C++, Java, JavaScript, and PHP, except that Go only runs the selected case, not all the cases that follow. In effect, the break statement that is needed at the end of each case in those languages is provided automatically in Go. Another important difference is that Go's switch cases need not be constants, and the values involved need not be integers.

   Go only runs the selected case, not all the cases that follow. （TODO:没看懂）

2.  Switch cases evaluate cases from top to bottom, stopping when a case succeeds.

   ```go
   switch i {
   case 0:
   case f():
   }
   ```
   does not call f if i==0.

3. `switch` without a condition is the same as `switch true`. This construct can be a clean way to write long if-then-else chains.

   ```go
   t := time.Now()
   switch {
   case t.Hour() < 12:
       fmt.Println("Good morning!")
   case t.Hour() < 17:
       fmt.Println("Good afternoon.")
   default:
       fmt.Println("Good evening.")
   }
   ```

### 6. `defer`

`defer`后的语句在所在函数结束后执行。不过其中的变量是碰到`defer`之后就确定的。

### 7. Pointer

Unlike C, Go has no pointer arithmetic.（TODO:并没有搞懂）

### 8. Struct

```go
type Vertex struct {
    X int
    Y int
}
```

### 9. Slice and Array

[Slice内部工作原理](https://blog.golang.org/go-slices-usage-and-internals)

> If the backing array of a slice is too small to fit all the given values, a bigger array will be allocated. The returned slice will point to the newly allocated array.

slice的用法过于奇葩，你还是直接到这个[链接](https://tour.golang.org/moretypes/7)上去看吧。

### 10. `range`

```go
for i, v := range pow {
    fmt.Printf("2**%d = %d\n", i, v)
}
```

`i`是index，`v`是对应元素。还可以进行一定的省略。

```go
for i := range pow
for i, _ := range pow
for _, value := range pow
```

### 11. Map

1. map加入key之前是一定要绑定的。

   ```go
   type Vertex struct {
       Lat, Long float64
   }
   // 像这样：
   var m map[string]Vertex
   m = make(map[string]Vertex)
   // 或是这样：
   var m = map[string]Vertex{
       "Bell Labs": Vertex{
           40.68433, -74.39967,
       },
       "Google": Vertex{
           37.42202, -122.08408,
       },
   }
   ```

2. 和map关系不大但是还写在这里算了。

   ```go
   // Right.
   m["Bell Labs"] = Vertex{ 40.68433, -74.39967 }
   // Right.
   m["Bell Labs"] = Vertex{ 40.68433, -74.39967, }
   // Right.
   m["Bell Labs"] = Vertex{
       40.68433, -74.39967,
   }
   // False!!!
   m["Bell Labs"] = Vertex{
       40.68433, -74.39967
   }
   ```

3. If the top-level type is just a type name, you can omit it from the elements of the literal.

   ```go
   type Vertex struct {
       Lat, Long float64
   }

   var m = map[string]Vertex{
       "Bell Labs": {40.68433, -74.39967},
       "Google":    {37.42202, -122.08408},
   }
   ```

4. 检测map中是否存在key。

   ```go
   elem, ok = m[key]
   // 如果elem, ok没被声明过
   elem, ok := m[key]
   ```

### 12. Function

1. 关于闭包。注意，这个实现方式貌似说明了`prev, next = next, prev + next`的计算顺序是先计算右边的东西，算完了之后统一赋给左边的变量。

   ```go
   func fibonacci() func() int {
       prev := 0
       next := 1
       return func() int {
           prev, next = next, prev + next
           return prev
       }
   }
   
   func main() {
       f := fibonacci()
       for i := 0; i < 10; i++ {
           fmt.Println(f())
       }
   }
   ```

2. 一些函数定义的方式。

   ```go
   func split(sum int) (x, y int) {
       x = sum * 4 / 9
       y = sum - x
       return
   }

   func swap(x, y string) (string, string) {
       return y, x
   }

   func add(x, y int) int {
       return x + y
   }
   ```
