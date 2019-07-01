# 开发环境的配置记录
## Editor
1. [Visual Studio code](https://code.visualstudio.com/)
2. [Emacs](http://www.gnu.org/software/emacs/)
3. [Vim](http://www.vim.org/)
## IDE
1. [Visual Studio](https://www.visualstudio.com/zh-hans/vs/)
2. [Jetbrains](https://www.jetbrains.com/) [Account](https://account.jetbrains.com/licenses)

目前，以VS code为主力编辑器。其setting.json似乎由于编码格式的问题暂不宜直接加入GitNote中，现将其内容和关于各种项目的配置文件放置在文件夹VScode中。
## Java(Windows)

### 配置环境变量

假设Java安装于D:\program\Java\jdk1.8.0_151，在Path中添加

    D:\program\Java\jdk1.8.0_151\bin

创建CLASS_PATH为

    .;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar;

创建JAVA_HOME为

    D:\program\Java\jdk1.8.0_151

在powershell中键入`java -version`及`javac -version`来检验是否成功安装。
