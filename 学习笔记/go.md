# Go 学习笔记
- [Go 学习笔记](#go-学习笔记)
  - [Documents](#documents)
  - [Features of Go Language](#features-of-go-language)
    - [1. Declaration of Variables](#1-declaration-of-variables)
    - [2. `for`](#2-for)
    - [3. `if`](#3-if)
    - [4. `switch`](#4-switch)
    - [5. `defer`](#5-defer)
    - [6. Pointer](#6-pointer)
    - [7. Struct](#7-struct)
    - [8. Slice and Array](#8-slice-and-array)
    - [9. `range`](#9-range)
    - [10. Map](#10-map)
    - [11. Function](#11-function)
    - [12. Method](#12-method)
    - [13. Interface](#13-interface)
    - [14. Error](#14-error)
    - [15. Printf](#15-printf)
    - [16. Channel](#16-channel)
  - [Other tips](#other-tips)
    - [1. Bug of Installing Tool Chains For Go](#1-bug-of-installing-tool-chains-for-go)
      - [失败原因](#失败原因)
    - [2. gopls](#2-gopls)

## Documents

- [A Tour of Go (Official)](https://tour.golang.org/welcome/1)
- [Answer of "A Tour of Go"](https://github.com/golang/tour/tree/master/solutions)

## Features of Go Language

### 1. Declaration of Variables

```go
var nmd, wsm string = "U", "SB"
var nmd, wsm = "U", "SB"
nmd, wsm := "U", "SB"
```

### 2. `for`

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

### 3. `if`

1. `{}`也是不能省略的。`()`也是不需要的。

2. `if`语句可以以一个赋值语句开始。不过这个值只在`if`语句内部才有用。

   ```go
   if v := math.Pow(x, n); v < lim {
       return v
   }
   ```

### 4. `switch`

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

### 5. `defer`

`defer`后的语句在所在函数结束后执行。不过其中的变量是碰到`defer`之后就确定的。

### 6. Pointer

Unlike C, Go has no pointer arithmetic.（TODO:并没有搞懂）

### 7. Struct

```go
type Vertex struct {
    X int
    Y int
}
/* 下面这个不是struct，不过可以这么干。 */
type MyFloat float64
```

### 8. Slice and Array

[Slice内部工作原理](https://blog.golang.org/go-slices-usage-and-internals)

> If the backing array of a slice is too small to fit all the given values, a bigger array will be allocated. The returned slice will point to the newly allocated array.

slice的用法过于奇葩，你还是直接到这个[链接](https://tour.golang.org/moretypes/7)上去看吧。

### 9. `range`

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

### 10. Map

1. map加入key之前是一定要绑定的。

   ```go
   type Vertex struct {
       Lat, Long float64
   }
   /* 像这样： */
   var m map[string]Vertex
   m = make(map[string]Vertex)
   /* 或是这样： */
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
   /* Right. */
   m["Bell Labs"] = Vertex{ 40.68433, -74.39967 }
   /* Right. */
   m["Bell Labs"] = Vertex{ 40.68433, -74.39967, }
   /* Right. */
   m["Bell Labs"] = Vertex{
       40.68433, -74.39967,
   }
   /* False!!! */
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
   /* 如果elem, ok没被声明过 */
   elem, ok := m[key]
   ```

### 11. Function

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

### 12. Method

1. Method只是接受了一个“对象”参数的函数而已。

   ```go
   type Vertex struct {
       X, Y float64
   }
   
   func Abs(v Vertex) float64 {
       return math.Sqrt(v.X*v.X + v.Y*v.Y)
   }
   
   func main() {
       v := Vertex{3, 4}
       fmt.Println(Abs(v))
   }
   ```

2. Method对应的对象必须和Method在同一个package内。

3. Method接收的receiver如果是指向对象的指针，Method就可以改变该对象的值。（所以，指针形式实际上更常见）如果receiver是对象的话值就不能改变了（这种情况下实际上是原来对象的拷贝被传给了Method）

   ```go
   func (v *Vertex) Scale(f float64) {
       v.X = v.X * f
       v.Y = v.Y * f
   }
   ```

4. Method被调用时，如果其receiver为指向对象的指针，则调用者即使是对象也会自动转成指向它的指针。

   ```go
   func (v *Vertex) Scale(f float64) {
       v.X = v.X * f
       v.Y = v.Y * f
   }
   var v Vertex
   v.Scale(5)  // OK. 这里v.Scale()被转化成了(&v).Scale()
   p := &v
   p.Scale(10) // OK.
   ```

   这里有个神奇的东西：如果receiver为对象，调用者为指针，编译并不会报错。（确实有这种用法）不过这样就无法改变对象本身的值了。

   ```go
   func (v Vertex) Abs() float64 {
       return math.Sqrt(v.X*v.X + v.Y*v.Y)
   }
   var v Vertex
   fmt.Println(v.Abs()) // OK.
   p := &v
   fmt.Println(p.Abs()) // OK. 这里p.Abs()被转化成了(*p).Abs()
   ```

### 13. Interface

1. 在Go中，Interface的value如果是`nil`的话，并不会出现什么问题。只要在调用的方法中加入对应的`nil`判断即可。

   ```go
   type I Interface {
       M()
   }

   type T struct {
       S string
   }

   func (t *T) M() {
       if t == nil {
           fmt.Println("<nil>")
           return
       }
       fmt.Println(t.S)
   }

   var i
   var t *T
   i.M() // 没有问题。
   ```

   注意这种情况下Interface本身并不是`nil`的。而如果Interface自己没有绑定对象，那就没办法了。

   ```go
   var i I
   i.M() // 会有runtime error。
   ```

2. 空的interface，`interface{}`，用来表示不知道具体类型（并不清楚有啥方法）的值。`fmt.Println()`就用这东西来代表跟在字符串后的参数。

3. Type assertions

   这东西可以检查interface内的值是否符合某个实例的类型（这句话是我乱讲的）。

   ```go
   var i interface{} = "hello"
   s := i.(string)      // Right.
   s, ok := i.(string)  // ok == true
   f, ok := i.(float64) // ok == false，但是不会报错。
   f = i.(float64)      // 报错interface conversion。
   ```

4. [Type switches](https://tour.golang.org/methods/16)

### 14. Error

1. 有个令人在意的地方。

   ```go
   /* err是实现了Error()的对象。 */
   fmt.Printf("Error %s", err)
   fmt.Printf("Error %v", err)
   /* 这两东西打出来的值是一样的。 */
   ```

2. 常见的错误处理方式。

   ```go
   type error interface {
       Error() string
   }

   i, err := strconv.Atoi("42")
   if err != nil {
       fmt.Printf("couldn't convert number: %v\n", err)
       return
   }
   ```

3. Error的实现的`Error()`方法，不能直接用`return fmt.Sprint(e)`，也不能`fmt.Sprintf("%v", e)`，要先把e转化为可打印的值。（不然貌似会无限调用`e.Error()`）。

   ```go
   type ErrNegativeSqrt float64
   /* Right. */
   func (e ErrNegativeSqrt) Error() string {
       return fmt.Sprintf("Sqrt: negative number %v", float64(e))
   }
   /* Right. */
   func (e ErrNegativeSqrt) Error() string {
       return fmt.Sprintf("Sqrt: negative number %g", e)
   }
   /* Wrong!!! */
   func (e ErrNegativeSqrt) Error() string {
       return fmt.Sprintf("Sqrt: negative number %v", e)
   }
   ```

### 15. Printf

直接看这个[链接](https://golang.org/pkg/fmt/)

### 16. Channel

1. 默认情况下，只有send的一端准备好了（`v <- ch`），receive的一端才能receive（`v := <-ch`）。

   > By default, sends and receives block until the other side is ready.

2. Channel不是总要关闭的。

   > Channels aren't like files; you don't usually need to close them. Closing is only necessary when the receiver must be told there are no more values coming, such as to terminate a range loop.

   只有Sender可以关闭Channel，receiver则不可以。（这貌似是个设计原则）

   > Sending on a closed channel will cause a panic.

3. Channel的一些语法特性。

   ```go
   /* Channel可以指定大小（如果不指定，Channel就是unbuffered的）。 */
   ch := make(chan int, 10)
   /* ok可以判断channel是否被关闭。 */
   v, ok := <-ch
   ```

4. tour里面的小问题。

   - unbuffered的Channel只有在Sender、Receiver都准备好的情况下可以工作，不然就会阻塞。所以，[#tour-currency-5](https://tour.golang.org/concurrency/5)里面的`c <- x`实际上可能执行第11次，但是下一次肯定会到`quit`然后推出，因为`c`阻塞住了。
   - [#tour-currency-6](https://tour.golang.org/concurrency/6)中，0.5秒的周期到了的时候，tick是可能发生的（所以可能有5次tick），但是下一次for循环到`select`的时候，tick中的值已经被拿掉了，而boom中的值还在，所以会走boom而结束。

## Other tips

### 1. Bug of Installing Tool Chains For Go

像`gocode`、`guru`、`gorename`这种东西貌似不是包括在Google官方工具包里面的（TODO:有待考证），所以VScode里面安装Go插件之后会提示要再装一下，不然补全之类的功能会很残废。不过，你让他自己装可能会出现下面这种输出

```
Installing github.com/golang/lint/golint FAILED

Installing github.com/cweill/gotests/... FAILED
Installing github.com/derekparker/delve/cmd/dlv SUCCEEDED
8 tools failed to install.
go-outline:
Error: Command failed: D:\Go\bin\go.exe get -u -v github.com/ramya-rao-a/go-outline
github.com/ramya-rao-a/go-outline (download)
Fetching https://golang.org/x/tools/go/buildutil?go-get=1
https fetch failed: Get https://golang.org/x/tools/go/buildutil?go-get=1: dial tcp 216.239.37.1:443: connectex: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond.
```

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

### 2. gopls

这东西还处在活跃开发状态，你要查看更新的时候，就这么搞。（下面的命令自然是适用于Windows平台的）

```shell
cd $env:GOPATH\src\golang.org\x\tools
git pull
go install golang.org/x/tools/cmd/gopls
```
