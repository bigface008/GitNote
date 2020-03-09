# Java 学习笔记

## Tips

### 如何确定一个'数字'是 NaN

```java
if (x == Double.NaN) /* is never true */
if (Double.isNaN(x)) /* check whether x is "not a number" */
```

### int, Double 不能转换为 boolean

```java
if (x = 0) /* Java 编译器会直接报错 */
```

### 使用变量前必须初始化

```java
int x;
System.out.println(x); /* Java 编译器会直接报错 */
```

另外, C++ 中, 变量的定义和声明是区分的. 但是 Java 中是不区分的.

### Java 没有内置幂运算

```java
double y = Math.pow(x, a) /* 相当于 x ^ a */
```

### 静态导入

```java
import static java.lang.Math.sqrt;
```

TODO:

### 空字符串的检查

主要问题在于, String类型的值是可以为 `null` 的, 而在 `null` 上调用 `equals()` 方法会报错, 所以在调用 `equals()` 前应当检查字符串是否为 `null`.

```java
String hello = "Hello";
if (hello != null && !hello.equals("")) {
    System.out.println("Just do it!");
}
```
