# Python 学习笔记

## Tips

### 编码

在计算机内存中，统一使用Unicode编码，当需要保存到硬盘或者需要传输的时候，就转换为UTF-8编码。（正确性存疑）

### 函数参数

1. 定义默认参数要牢记一点：默认参数必须指向不变对象！（这其实只是个指导原则，python里面这么做是可以的，不过不推荐就是了......）
   
   ```python
   def add_end(L=[]):
       L.append('END')
       return L
   
   # 这样做会导致下面情况的发生
   >>> add_end()
   ['END']
   >>> add_end()
   ['END', 'END']
   >>> add_end()
   ['END', 'END', 'END']
   ```

   Python函数在定义的时候，默认参数`L`的值就被计算出来了，即`[]`，因为默认参数`L`也是一个变量，它指向对象`[]`，每次调用该函数，如果改变了`L`的内容，则下次调用时，默认参数的内容就变了，不再是函数定义时的`[]`了。

   ```python
   # 所以你可以这么做......
   def add_end(L=None):
       if L is None:
           L = []
       L.append('END')
       return L

   >>> add_end()
   ['END']
   >>> add_end()
   ['END']
   ```

2. 如果要限制关键字参数的名字，就可以用命名关键字参数，例如，只接收`city`和`job`作为关键字参数。这种方式定义的函数如下：

   ```python
   def person(name, age, *, city, job):
       print(name, age, city, job)
   ```

   和关键字参数`**kw`不同，命名关键字参数需要一个特殊分隔符`*`，`*`后面的参数被视为命名关键字参数。

   调用方式如下：
   
   ```python
   >>> person('Jack', 24, city='Beijing', job='Engineer')
   Jack 24 Beijing Engineer
   ```

   如果函数定义中已经有了一个可变参数，后面跟着的命名关键字参数就不再需要一个特殊分隔符`*`了：

   ```python
   def person(name, age, *args, city, job):
       print(name, age, args, city, job)
   ```

   命名关键字参数必须传入参数名，这和位置参数不同。如果没有传入参数名，调用将报错：

   ```python
   >>> person('Jack', 24, 'Beijing', 'Engineer')
   Traceback (most recent call last):
     File "<stdin>", line 1, in <module>
   TypeError: person() takes 2 positional arguments but 4 were given
   ```

   由于调用时缺少参数名`city`和`job`，Python解释器把这4个参数均视为位置参数，但`person()`函数仅接受2个位置参数。

   命名关键字参数可以有缺省值，从而简化调用：

   ```python
   def person(name, age, *, city='Beijing', job):
       print(name, age, city, job)
   ```

   由于命名关键字参数`city`具有默认值，调用时，可不传入`city`参数：

   ```python
   >>> person('Jack', 24, job='Engineer')
   Jack 24 Beijing Engineer
   ```

   使用命名关键字参数时，要特别注意，如果没有可变参数，就必须加一个`*`作为特殊分隔符。如果缺少`*`，Python解释器将无法识别位置参数和命名关键字参数：

   ```python
   def person(name, age, city, job):
       # 缺少 *，city和job被视为位置参数
       pass
   ```

3. 参数定义的顺序必须是：必选参数、默认参数、可变参数、命名关键字参数和关键字参数。

### 杨辉三角

   ```python
   def gen(max):
       re = [1]
       while max:
           yield re
           re = [a + b for (a, b) in zip([0] + re, re + [0])]
           max -= 1
   ```

### 闭包、循环变量

返回闭包时牢记一点：返回函数不要引用任何循环变量，或者后续会发生变化的变量。 

```python
def count():
    fs = []
    for i in range(1, 4):
        def f():
             return i*i
        fs.append(f)
    return fs

f1, f2, f3 = count()

# 对应输出
>>> f1()
9
>>> f2()
9
>>> f3()
9
```

如果一定要引用循环变量怎么办？方法是再创建一个函数，用该函数的参数绑定循环变量当前的值，无论该循环变量后续如何更改，已绑定到函数参数的值不变：

```python
def count():
    def f(j):
        def g():
            return j*j
        return g
    fs = []
    for i in range(1, 4):
        fs.append(f(i)) # f(i)立刻被执行，因此i的当前值被传入f()
    return fs

# 对应输出
>>> f1, f2, f3 = count()
>>> f1()
1
>>> f2()
4
>>> f3()
9
```

缺点是代码较长，可利用lambda函数缩短代码。

### 装饰器函数

装饰器函数是个大坑。

```python
import functools

def log(func):
    @functools.wrap(func)
    def wrapper(*args, **kw):
        print('call %s():' % func.__name__)
        return func(*args, **kw)
    return wrapper

@log
def now():
    print('2015-3-25')

>>> now()
call now():
2015-3-25

>>> now = log(now)

# 如果要加上参数，就要三层。
def log(text):
    def decorator(func):
        @functools.wrap(func)
        def wrapper(*args, **kw):
            print('%s %s():' % (text, func.__name__))
            return func(*args, **kw)
        return wrapper
    return decorator

@log('execute')
def now():
    print('2015-3-25')

>>> now()
execute now():
2015-3-25

>>> now = log('execute')(now)
```

### 私有变量

类中的变量如果开头加上`__`，就不能被外部访问了。（其实是可以的，不过解释器会把变量变成另外一个名字，当然你不应该试图访问这种“私有变量”）

### isinstance

可以判断一个变量是否是某些类型中的一种，比如下面的代码就可以判断是否是list或者tuple

```python
>>> isinstance([1, 2, 3], (list, tuple))
True
>>> isinstance((1, 2, 3), (list, tuple))
True
```

### 文件读写与try...finally

由于文件读写时都有可能产生IOError，一旦出错，后面的`f.close()`就不会调用。所以，为了保证无论是否出错都能正确地关闭文件，我们可以使用`try ... finally`来实现：

```python
try:
    f = open('/path/to/file', 'r')
    print(f.read())
finally:
    if f:
        f.close()
```

但是每次都这么写实在太繁琐，所以，Python引入了`with`语句来自动帮我们调用`close()`方法：

```python
with open('/path/to/file', 'r') as f:
    print(f.read())
```

这和前面的`try ... finally`是一样的，但是代码更佳简洁，并且不必调用`f.close()`方法。

### 尾递归

尾递归是指，在函数返回的时候，调用自身本身，并且，return语句不能包含表达式。这样，编译器或者解释器就可以把尾递归做优化，使递归本身无论调用多少次，都只占用一个栈帧，不会出现栈溢出的情况。

不过其实很多语言的编译器（包括Python）都不支持这个特性......

具体可以看看[这个链接](https://www.zhihu.com/question/20761771)

```python
# 阶乘
# 非尾递归
def fact(n):
    if n==1:
        return 1
    return n * fact(n - 1)

# 尾递归
def fact(n):
    return fact_iter(n, 1)

def fact_iter(num, product):
    if num == 1:
        return product
    return fact_iter(num - 1, num * product)
```

针对尾递归优化的语言可以通过尾递归防止栈溢出。尾递归事实上和循环是等价的，没有循环语句的编程语言只能通过尾递归实现循环。

Python标准的解释器没有针对尾递归做优化，任何递归函数都存在栈溢出的问题。
