# Python 学习笔记

## Tips

1. 在计算机内存中，统一使用Unicode编码，当需要保存到硬盘或者需要传输的时候，就转换为UTF-8编码。（正确性存疑）

2. 定义默认参数要牢记一点：默认参数必须指向不变对象！（这其实只是个指导原则，python里面这么做是可以的，不过不推荐就是了......）
   
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

3. 如果要限制关键字参数的名字，就可以用命名关键字参数，例如，只接收`city`和`job`作为关键字参数。这种方式定义的函数如下：

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

4. 参数定义的顺序必须是：必选参数、默认参数、可变参数、命名关键字参数和关键字参数。

5. 杨辉三角

   ```python
   def gen(max):
       re = [1]
       while max:
           yield re
           re = [a + b for (a, b) in zip([0] + re, re + [0])]
           max -= 1
   ```

6. 返回闭包时牢记一点：返回函数不要引用任何循环变量，或者后续会发生变化的变量。 

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
