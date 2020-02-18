# Python 学习笔记

## Tips

### 编码

在计算机内存中，统一使用Unicode编码，当需要保存到硬盘或者需要传输的时候，就转换为UTF-8编码。（正确性存疑）

### 函数参数

```python
def print_params(*args, **kw):
    print(args, kw)
```

星号的意思可以理解为收集其余的**位置参数**, 

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

普通的实现：

```python
def gen(max):
    re = [1]
    while max:
        yield re
        re = [a + b for (a, b) in zip([0] + re, re + [0])]
        max -= 1
```

如果要用生成器的话？**这里有个有意思的问题**。

```python
# 1st Implementation
def triangles():
    L = [1]
    while True:
        yield L
        L.append(0)
        for i in range(len(L) - 1, 0, -1):
            L[i] += L[i - 1]

# 2nd Implementation
def triangles3():
    L = [1]
    while True:
        yield L
        L = [1] + [L[n]+L[n+1] for n in range(len(L)-1)] + [1]

# 测试代码
n = 0
results = []
for t in myFunc.triangles():
    # print(t)
    results.append(t)
    n = n + 1
    if n == 10:
        break

for t in results:
    print(t)
```

你会发现，第一种实现的输出会是这样（有问题）

```
[1, 9, 36, 84, 126, 126, 84, 36, 9, 1]
[1, 9, 36, 84, 126, 126, 84, 36, 9, 1]
[1, 9, 36, 84, 126, 126, 84, 36, 9, 1]
[1, 9, 36, 84, 126, 126, 84, 36, 9, 1]
[1, 9, 36, 84, 126, 126, 84, 36, 9, 1]
[1, 9, 36, 84, 126, 126, 84, 36, 9, 1]
[1, 9, 36, 84, 126, 126, 84, 36, 9, 1]
[1, 9, 36, 84, 126, 126, 84, 36, 9, 1]
[1, 9, 36, 84, 126, 126, 84, 36, 9, 1]
[1, 9, 36, 84, 126, 126, 84, 36, 9, 1]
```

第二种实现的输出会是这样（正确）
```
[1]
[1, 1]
[1, 2, 1]
[1, 3, 3, 1]
[1, 4, 6, 4, 1]
[1, 5, 10, 10, 5, 1]
[1, 6, 15, 20, 15, 6, 1]
[1, 7, 21, 35, 35, 21, 7, 1]
[1, 8, 28, 56, 70, 56, 28, 8, 1]
[1, 9, 36, 84, 126, 126, 84, 36, 9, 1]
```

究其原因，是因为**python中的list中的每一项实际上是一个个引用，引用指向对应的数据**。
在第一种实现中，你每次改变L原来指向位置的数据的值，并且返回指向同一个位置的引用（L），会使得results中的每一项指向的值（同一个）不断变化。
第二种实现中，每次都把L置为了一个新的值，使得results中每个元素为不同的数据的引用，自然得到正确的值。

为了加深印象，你可以看看下面。

```shell
>>> V = []
>>> V.append(0)
>>> LV = []
>>> LV.append(V)
>>> LV
[[0]]
>>> V.append(1)
>>> LV
[[0, 1]]
>>> V = [2]
>>> LV
[[0, 1]]
>>> LV.append(V)
>>> LV
[[0, 1], [2]]
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

本质上来说，在`now`定义前面加上`@log()`，就相当于语句`now = log(now)`。

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

另外, 前面有下划线的名字都不会被带有星号的 `import` 语句 `from module import *` 导入.

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

### Iterable & Iterator

`list`、`dict`、`str`都是`Iterable`，但不是`Iterator`。生成器都是`Iterator`，并且也是`Iterable`的。

> 你可能会问，为什么list、dict、str等数据类型不是Iterator？
>
> 这是因为Python的Iterator对象表示的是一个数据流，Iterator对象可以被next()函数调用并不断返回下一个数据，直到没有数据时抛出StopIteration错误。可以把这个数据流看做是一个有序序列，但我们却不能提前知道序列的长度，只能不断通过next()函数实现按需计算下一个数据，所以Iterator的计算是惰性的，只有在需要返回下一个数据时它才会计算。
>
> Iterator甚至可以表示一个无限大的数据流，例如全体自然数。而使用list是永远不可能存储全体自然数的。
>
> --摘自廖雪峰老师的Python教程

凡是可作用于`for`循环的对象都是`Iterable`类型；

凡是可作用于`next()`函数的对象都是`Iterator`类型，它们表示一个惰性计算的序列；

集合数据类型如`list`、`dict`、`str`等是`Iterable`但不是`Iterator`，不过可以通过`iter()`函数获得一个`Iterator`对象。

Python的`for`循环本质上就是通过不断调用`next()`函数实现的，例如：

```python
for x in [1, 2, 3, 4, 5]:
    pass
```

实际上完全等价于：

```python
# 首先获得Iterator对象:
it = iter([1, 2, 3, 4, 5])
# 循环:
while True:
    try:
        # 获得下一个值:
        x = next(it)
    except StopIteration:
        # 遇到StopIteration就退出循环
        break
```

### 空字符串相当于`Flase`（但不等于`False`）

```python
# 无输出
s = ''
if s:
    print('SB')
if s == False:
    print('SB')
```

### `filter()`也是惰性序列


### `nonlocal`

> The `nonlocal` statement causes the listed identifiers to refer to previously bound variables in the nearest enclosing scope excluding globals.

```python
# 比方说，写一个每次调用返回+1的值的计数器，用闭包函数实现。
def createCounter():
    i = 0

    def counter():
        nonlocal i
        i += 1
        return i

    return counter

# 当然也可以用generator就是了。
```

### 类可以直接绑定变量

```python
>>> bart = Student('bart', 100)
>>> lily = Student('lily', 100)
>>> bart.age = 30
>>> lily.age
Traceback (most recent call last):
  File "<input>", line 1, in <module>
AttributeError: 'Student' object has no attribute 'age'
```

当然各个实列间不会互相影响。

### 鸭子类型

> 一个对象只要 "看起来像鸭子, 走起路来像鸭子", 那它就可以被看做是鸭子.

这是对于动态语言来说的.  (静态语言, 例如 java, 就不能这么干)

```python
# 只要传入的对象有 run() 这一方法就没问题。
def run_twice(animal):
    animal.run()
    animal.run()
```

### 类本身属性不应和实例属性同名

```python
>>> class Student(object):
...     name = 'Student'
...
>>> s = Student() # 创建实例 s
>>> print(s.name) # 打印 name 属性，因为实例并没有 name 属性，所以会继续查找 class 的 name 属性
Student
>>> print(Student.name) # 打印类的 name 属性
Student
>>> s.name = 'Michael' # 给实例绑定 name 属性
>>> print(s.name) # 由于实例属性优先级比类属性高，因此，它会屏蔽掉类的 name 属性
Michael
>>> print(Student.name) # 但是类属性并未消失，用 Student.name 仍然可以访问
Student
>>> del s.name # 如果删除实例的 name 属性
>>> print(s.name) # 再次调用 s.name, 由于实例的 name 属性没有找到，类的 name 属性就显示出来了
Student
```

### `__slot__`

使用 `__slots__` 要注意, `__slots__` 定义的属性仅对当前类实例起作用, 对继承的子类是不起作用的.

除非在子类中也定义 `__slots__`, 这样, 子类实例允许定义的属性就是自身的 `__slots__` 加上父类的 `__slots__`.

### `__getattr__`

注意，只有在没有找到属性的情况下，才调用 `__getattr__`，已有的属性，比如name，不会在 `__getattr__` 中查找.

### `repr()` 和反引号

Python 3.0 目前已经不适用反引号了, 你得坚持用 `repr()`.

> `repr()` 的作用是以合法的 Python 表达式的形式来表示值.

### 原始字符串末尾不可以是反斜杠

就是说 `r'Hello, world!\'` 是不行的.

### Python 2 和 Python 3 中的 `input()`

在 Python 3 中, `input()` 的行为如下。

```python
>>> x = input('x: ')
x: 12
>>> x
'12'
```

而在 Python 2 中, 相同的功能是 `raw_input()` 来实现的, 它会认为输入的值是单纯的字符串.

Python 2 中的 `input()` 表示的则是计算了这个字符串后得到的值. 

```python
# Python 2
>>> x = input('x: ')
x: 12
>>> x
12
```

也就是说，它认为输入的应当是合法的 Python 表达式, 如果输入了普通的字符串, 比如

```python
>>> input('sth: ')
sth: Ted
# 报错信息.
```

就会报错.

下面是在 [stackover flow](https://stackoverflow.com/questions/954834/how-do-i-use-raw-input-in-python-3) 上找到的信息.

> There was originally a function input() which acted something like the current eval(input()). It was a leftover from when Python was less security conscious.

### `sorted()` & `sort()`

`sorted()` 函数不能改变输入的列表的值 (也可以输入元组) .

```python
>>> a = [1, 3, 2]
>>> sorted(a)
[1, 2, 3]
>>> a
[1, 3, 2]
```

另外, `sorted()` 返回值必然为列表.

```python
>>> s = 'Python'
>>> sorted(s)
['P', 'h', 'n', 'o', 't', 'y']
```

`sort()` 方法会在原位改变输入列表的值.

```python
>>> a = [1, 3, 2]
>>> a.sort() # 返回值为 None.
>>> a
[1, 2, 3]
```

对于元组也是一样的.

### 分片赋值

总之是个很强的特性.

```python
>>> name = list('Perl')
>>> name
['P', 'e', 'r', 'l']
>>> name[2:] = list('ar')
>>> name
['P', 'e', 'a', 'r']
>>> name[2:3] = ['e']
>>> name
['P', 'e', 'e', 'r']
>>> name[1:] = list('ython')
>>> name
['P', 'y', 't', 'h', 'o', 'n']
```

### `extend()` 方法

```python
>>> a = [1, 2, 3]
>>> b = [4, 5, 6]
>>> a.extend(b)
>>> a
[1, 2, 3, 4, 5, 6]
```

自然地, 用 `a = a + b` 的方式也能达到相同的效果, 但是这样的连接操作效率会比 `extend()` 要低.

### 先进先出? 用 `collection` 中的 `deque`.

pass

### Python 中的字符串是不可变的

也就是说不能分片赋值.

### `string.letters`

Python 3.0 中, `string.letters` 相关的东西都被移除. 需要的话应当使用 `string.ascii_letters` 代替.

### `join()` & `split()`

这两个东西的对象, 参数的顺序是反过来的.

```python
>>> path = ['usr', 'bin', 'env']
>>> '/'.join(path)
'usr/bin/env'
>>> path
['usr', 'bin', 'env']
>>> path = 'usr/bin/env'
>>> path.split('/')
['usr', 'bin', 'env']
```

另外, 他们都不会改变对象的值. (Python 中的字符串是不可改变的)

### `translate()` & `str.maketrans()`

Python 3 里这两东西和 Python 2 里有很大区别.

首先 Python 2 里是有 `maketrans()` 的:

```python
from string import maketrans
```

但是 Python 3 里需要用 `str.maketrans`, `bytearray.maketrans`, `bytes.maketrans`.

其次, Python 2 里 `translate()` 有第二个参数, 表示要在调用的字符串中删除所有该参数, Python 3 里面的 `translate()` 则只有一个参数.

要实现将 `'ab ab ab'` 中的 'a', 'b' 分别替换成 '1', '2', 并且删除所有空格, 在 Python 3 中需要这么操作:

```python
# 可以理解为把 'ab' 替换为 '12', 把 ' ' 替换为 None.
>>> table = str.maketrans('ab', '12', ' ')
>>> 'ab ab ab ab'.translate(table)
'12121212'
```

### 字典, 列表, 深浅复制

首先, 对于字典, 深浅复制的区别在于, 浅复制只会复制到第一层元素指向的位置, 而深复制则会复制到第一层元素指向的位置上放的值。

```python
x = {'username': 'admin', 'machines': ['foo', 'bar', 'baz']}

# 深复制
from copy import deepcopy
y = deepcopy(x)
y['username'] = 'mlh'
print('x:', x, 'y:', y)      # x: {'username': 'admin', 'machines': ['foo', 'bar', 'baz']} y: {'username': 'mlh', 'machines': ['foo', 'bar', 'baz']}
y['machines'].remove('bar')
print('x:', x, 'y:', y)      # x: {'username': 'admin', 'machines': ['foo', 'bar', 'baz']} y: {'username': 'mlh', 'machines': ['foo', 'baz']}

# 浅复制
y = x.copy()
y['username'] = 'mlh'
print('x:', x, 'y:', y)      # x: {'username': 'admin', 'machines': ['foo', 'bar', 'baz']} y: {'username': 'mlh', 'machines': ['foo', 'bar', 'baz']}
y['machines'].remove('bar')
print('x:', x, 'y:', y)      # x: {'username': 'admin', 'machines': ['foo', 'baz']} y: {'username': 'mlh', 'machines': ['foo', 'baz']}
```

### `items()`, `iteritems()`, `keys()`, `iterkeys()`, `values()`

Python 2 中存在的 `dict` 的方法, 用来返回键值对的列表的 `items()` 方法和返回键值对列表迭代器的 `iteritems()` 方法, 在 Python 3 中都没了.

Python 3 中的 `items()` 返回的是一个可以用 `for` 进行迭代的不明物体. (貌似是叫 `dict_items` 对象)

同样的, `keys()` 方法的返回值也从键的列表, 变成了 `dict_keys` 对象. `iterkeys()` 方法也没了. `values()` 返回的也是个 `dict_values` 对象.

```python
>>> d = {'title': 'Python Web Site', 'url': 'http://www.python.org', 'spam': 0}
>>> print(d.items())
dict_items([('title', 'Python Web Site'), ('url', 'http://www.python.org'), ('spam', 0)])
>>> print(d.keys())
dict_keys(dict_keys(['title', 'url', 'spam']))
```

### `setdefault()` 一个看上去脱裤子放屁实则有点东西的方法

字典中不存在第一参数的键的时候, 加入相应键值对.

字典中存在第一参数的键的时候, 不改变对应值并且返回字典中对应值.

```python
>>> d = {}
>>> d.setdefault('name', 'N/A')
'N/A'
>>> d
{'name': 'N/A'}
>>> d['name'] = 'Ted'
>>> d
{'name': 'Ted'}
>>> d.setdefault('name', 'N/A')
'Ted'
>>> d
{'name': 'Ted'}
```

所以, 这东西咋用呢?

举个例子, 找出首字母相同的男生, 女生的名字组合.

```python
# 普通方法
>>> girls = ['Alice', 'Bernice', 'Clarice']
>>> boys = ['Chris', 'Arnold', 'Bob']
>>> [b + ' ' + g for b in boys for g in girls if b[0] == g[0]]

# 上面的方法要尝试每一种选择, 效率较低. Python 有很多方法解决这个问题, 比如
letterGirls = {}
for girl in girls:
    letterGirls.setdefault(girl[0], []).append(girl)
print([b + ' ' + g for b in boys for g in letterGirls[b[0]]])
```

### 垃圾回收

Python 中, 你无法删除一个值, 你只能删除它对应的名称. 删除值的工作是由垃圾回收模块负责的.

```python
>>> x = ['Hello', 'world']
>>> y = x
>>> y[1] = 'Python
>>> x
['Hello', 'Python']
>>> del x
>>> y
['Hello', 'Python']
```

删除的只是名称, 而不是列表本身.

### 多重继承

多重继承据说是个大坑, 尽量少用为妙. 另外, 如果多个超类以不同的方式实现了同一个方法 (即有多个同名方法), 必须在 `class` 语句中小心排列这些超类, 因为位于前面的类的方法将覆盖位于后面的类的方法.


