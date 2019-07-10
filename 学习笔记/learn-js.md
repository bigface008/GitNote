# JavaScript 学习笔记

> 实际上JSX的笔记也许应该记在这里......

1. In JavaScript, `null` is not a “reference to a non-existing object” or a “null pointer” like in some other languages. It’s just a special value which represents “nothing”, “empty” or “value unknown”.
   
   话是这么说，但是：
   
   ```javascript
   > typeof null
   'object'
   ```

2. js的数字转换有点神奇。

   ```javascript
   console.log(2 + '1');          // 21
   console.log(typeof (2 + '1')); // string
   console.log(2 - '1');          // 1
   console.log(typeof (2 - '1')); // number
   ```

3. js中`,`的用法相当神奇。
   The comma operator allows us to evaluate several expressions, dividing them with a comma ,. Each of them is evaluated but only the result of the last one is returned.

   ```javascript
   let n = (1 + 2, 3 + 4);
   console.log(n); // 7, result of 3 + 4
   ```

4. js中`==`和`===`的区别。注意一般推荐用`===`。

   ```javascript
   console.log(true == 1);
   console.log(true === 1);
   console.log(false == 0);
   console.log(false === 0);
   ```

5. js里面有很烦人的`null`，`undefined`和`0`之间的比较问题，总之你不要做类似的事就行了......

6. js中函数的变量的默认值的计算。

   ```javascript
   function showMessage(from, text = anotherFunction()) {
     // anotherFunction() only executed if no text given
     // its result becomes the value of text
   }
   ```

   In JavaScript, *a default parameter is evaluated every time the function is called without the respective parameter.* In the example above, `anotherFunction()` is called every time `showMessage()` is called without the text parameter. This is in contrast to some other languages like **Python**, where any default parameters are evaluated only once during the initial interpretation.

7. 保留字符（关键字）是允许作为`object`的`key`的。

   ```javascript
   let obj = {
     for: 1,
     let: 2,
     return: 3
   };
   ```

8. `object`的属性赋值可以缩写。

   ```javascript
   function makeUser(name, age) {
     return {
       name: name,
       age: age
     };
   }

   function makeUser(name, age) {
     return {
       name, // same as name: name
       age   // same as age: age
       // ...
     };
   }

   let user = {
     name,
     age
   }
   ```

9. 
