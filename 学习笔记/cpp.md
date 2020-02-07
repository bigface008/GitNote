# C++ 零碎知识点笔记

在这里记录一些你学C++时遇到的坑。记住，书上有的就不用再写到这里了。

~~考虑到C++的语法实际上有很多坑，在这里逐一记录的效率过低，你还是好好在C++ Primer书上划重点吧。~~
~~这篇笔记的主要作用是让你电话面试的时候可以速查一下。所以**语言简明扼要且完整准确**是很重要的。~~

另外，你**不应当依赖这篇笔记来记忆**。每次对这篇笔记的编写/修改都应当发生在你看完一整章/一天的阅读结束后。

C++ Primer 阅读进度：**100/764**

## Tips

### EOF

EOF这个东西在windows上的输入方法是：Ctrl+Z，然后按Enter。UNIX系统中则是Ctrl+D。

### `std::endl`

`std::endl`的效果是结束当前行，并将与设备关联的buffer中的内容刷到设备中。*buffer刷新的操作可以保证到目前为止程序所产生的所有输出都真正写入输出流中，而不是仅停留在内存中等待写入流*。

### `extern`

函数体内，如果试图初始化一个由`extern`关键字标记的变量，将引发错误。

### 指定C++标准的版本

```shell
# 貌似Ubuntu 16.04上默认的g++默认不是用C++ 11版本的。
$ g++ -std=c++11 -o app main.cpp
```

### `auto` & `const_iterator`

TODO: 搞清楚以下问题

下面代码片段中的`it`到底是`iterator`还是`const_iterator`。

```cpp
auto it = v.cbegin();
auto it1 = v.cbegin() + v.size() / 2; /* 就使用情况来看应该是普通的iterator。 */
```

另外，下面的操作貌似是可以的，那......

```cpp
auto it = v.cbegin();
it++;
cout << it - v.cbegin() << endl; /* 1 */
```

### 内置类型变量的初始化

在函数体外部的内建类型变量会默认初始化为0，而函数内部的内建类型变量则会初始化为**未定义**的值。（这不对吧？）

而有的`class`是有默认初始化值的（即使在函数内部），如`std::string `。是否提供默认初始化函数，或者是否强制要求显式初始化，是`class`本身的特性。

### 在作用域内已经定义了一个覆盖全局变量的局部变量时，如何获取全局变量的值？

```cpp
#include <iostream>

int r = 42;

int main() {
    std::cout << r << std::endl;   /* 42 */
    int r = 0;
    std::cout << r << std::endl;   /* 0 */
    std::cout << ::r << std::endl; /* 42 */
    std::cout << r << std::endl;   /* 0 */
}
```

## Features

### 引用

> 引用就是它指向对象的另外一个名称而已。

记住上面这句话就差不多了（不是

1. 引用必须被初始化。

   > 一般地，在初始化变量时，初始值会被拷贝到新建的对象中。
   >
   > 然而定义引用时，程序把引用和它的初始值绑定（bind）在一起，而不是将初始值拷贝给引用。一旦初始化完成，引用将和它的初始值对象一直绑定在一起。因为无法令引用重新绑定到另外一个对象，因此引用必须初始化。

2. 引用本身不是一个对象，所以不能定义引用的引用。（正如一个名字不会有一个名字）

3. > 为引用赋值，是把值付给了与引用绑定的对象。获取引用的值，是获取了与引用绑定的对象的值。以引用为初始值，是以与引用绑定的对象作为初始值。

4. 引用初始化时是可以绑定常量的，不过引用本身也必须为常量。

   ```cpp
   int &ref1 = 1;       // X
   const int &ref2 = 1; // V
   ```

### 指针

1. 与引用的不同点。

   - 指针本身就是一个对象，允许对指针赋值和拷贝，而且在指针的生命周期内它可以先后指向几个不同的对象。
   - 指针无需在定义时赋初值。

2. C++11中引入了关键字`nullptr`作为空指针的值。在新的标准下最好用`nullptr`而非`NULL`初始化指针。

3. **指向常量的指针**不能用于改变其所指向的对象的值。要想存放常量对象的地址，只能使用指向常量的指针。

   ```cpp
   const double pi = 3.14;
   double *ptr = &pi;
   const double *cptr = &pi;
   *cptr = 42;
   ```

4. `const`有*top-level*和*low-level*之分。
   
   显然的，指针本身是不是常量和指针所指对象是不是常量是两个问题。

   - **top-level const** 表示指针本身是个常量。
   - **low-level const** 表示指针所指的对象是个常量。

   ```cpp
   int val = 10;
   int i = 0;
   int *const p1 = &i;       // 不能改变p1的值，这是一个顶层const。
   *p1 = val;                // 不过可以改变p1指向对象的值。
   const int ci = 42;        // 不能改变ci的值，这是一个顶层const。
   const int *p2 = &ci;      // 允许改变p2的值，这是一个底层const。
   const int *const p3 = p2; // 靠右的const是顶层const，靠左的是底层const。
   const int &r = ci;        // 用于声明引用的const都是底层的const。
   ```

### `extern`

1. `const`

   关于`const`的坑请详细看**C++ Primer p55**。

   ```cpp
   const in bufSize = 512;
   ```

   P54:

   > 编译器在编译过程中把用到该变量的地方都替换成对应的值。也就是说，编译器会找到代码中所有用到bufSize的地方，然后用512替换。
   > 默认情况下，const对象被设定为仅在文件内有效。
   > 有时候，有的const变量初始值不是一个常量表达，这种变量要在文件间共享的时候，我们通常这么做。

   ```cpp
   /* file1.h头文件中的声明由extern做了限定，其作用是指明bufSize并非本文件独有，它的定义将在别处出现。 */
   extern const int bufSize = fcn(); // file1.cc定义并初始化一个常量，该常量能被其他文件访问。
   extern const int bufSize;         // file1.h头文件，这里面的bufSize和file1.cc中的是同一个。
   ```

### `const` & `constexpr`

#### 常量表达式

**常量表达式（const expression）**是指值不会改变，并且在编译过程中就能得到计算结果的表达式。（`constexpr`的具体内容请看 C++ Primer p58。）

`constexpr`是 C++ 11 新标准规定的东西。将变量声明为`constexpr`类型，可以让编译器来验证变量的值是否是一个常量表达式。

```cpp
const int sz = get_size()  // 不是常量表达式。
constexpr int fz = size(); // 只有当size是一个constexpr函数的时候，这才是一条正确的声明语句。
```

当指针、引用为`constexpr`的时候，它们的初始值受到诸多限制。一个`constexpr`的指针的初始值必须是`nullptr`或0，或是存储于某个固定地址中的对象。

函数体内定义的变量一般并非存放在固定地址中，因此`constexpr`指针不能指向这样的变量。相反的，定义于函数外的对象的地址是固定的，可以用于初始化`constexpr`指针。另外，有一类函数中定义，有效范围超出函数本身的变量，这类变量也拥有固定地址。`constexpr`引用能绑定到这样的变量上，`constexpr`指针也能指向这样的变量。

#### 类型别名

**C++ Prime p61**

```cpp
typedef char *pstring;  // 声明语句中用到pstring时，其基本数据类型是指针。
const pstring cstr = 0; // 声明了一个指向char的常量指针。
const char *cstr2 = 0;  // 对上面一句的错误理解。声明了一个指向const char的指针。
```

### `auto`

使用`auto`在一条语句中声明多个变量的时候，一条声明语句只能有一个剧本数据类型，所以该语句中所有变量的初始基本数据类型应当相同。

```cpp
auto i = 0, *p = &i;    // 正确：i是整数，p是整形指针。
auto sz = 0, pi = 3.14; // 错误：sz和pi的类型不一样。
```

其次，`auto`一般会忽略掉顶层`const`，同时底层`const`则会保留下来，比如当初始值是一个指向常量的指针时。

```cpp
int i = 0;
const int ci = i, &cr = ci;
auto b = ci; // b是一个整数（ci的顶层const特性被忽略掉了）。
auto c = cr; // c是一个整数（cr是ci的别名，ci本身是一个顶层const）。
auto d = &i; // d是一个整形指针（整数的地址就是）。
```

如果希望`auto`类型是一个顶层`const`，需要明确指出：

```cpp
const auto f = ci; // ci的推演类型是int，f则是const int。
```
