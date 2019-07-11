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