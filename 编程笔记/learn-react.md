# React 学习笔记

## Tips
1. React的函数不应当修改当前组件的`props`的值。*Props are Read-Only.*

   All React components must act like pure functions with respect to their props. *Whether you declare a component as a function or a class, it must never modify its own props.* Consider this sum function:
   ```javascript
   function sum(a, b) {
     return a + b;
   }
   ```
   Such functions are called “pure” because they do not attempt to change their inputs, and always return the same result for the same inputs.

   In contrast, this function is impure because it changes its own input:
   ```javascript
   function withdraw(account, amount) {
     account.total -= amount;
   }
   ```

   但是javascript本身是可以这样做的（貌似不推荐这么做？）
   
2. React中，不参与Component的数据流的变量，可以尽情地绑定到this中。

   While this.props is set up by React itself and this.state has a special meaning, you are free to add additional fields to the class manually if you need to store something that doesn’t participate in the data flow (like a timer ID).
   ```javascript
   componentDidMount() {
     this.timerID = setInterval(
       () => this.tick(),
       1000
     );
   }

   componentWillUnmount() {
     clearInterval(this.timerID);
   }
   ```

3. React中，`this.setState()`的用法需要注意。
   For example, this code may fail to update the counter:
   ```javascript
   // Wrong
   this.setState({
     counter: this.state.counter + this.props.increment,
   });
   ```

   To fix it, use a second form of setState() that accepts a function rather than an object. That    function will receive the previous state as the first argument, and the props at the time the update    is applied as the second argument:
   ```javascript
   // Correct
   this.setState((state, props) => ({
     counter: state.counter + props.increment
   }));
   ```

4. React中的Component首字母必须大写。
   *Note: Always start component names with a capital letter.*

   React treats components starting with lowercase letters as DOM tags. For example, `<div />` represents an HTML div tag, but `<Welcome />` represents a component and requires Welcome to be in scope.

5. React中，event的调用和html中event的调用有一些区别。
   - React
      ```html
      <button onClick={activateLasers}>
        Activate Lasers
      </button>
      ```
   - html
      ```html
      <button onClick="activateLasers()">
        Activate Lasers
      </button>
      ```
   另外，如果要阻止event的默认行为，两者要做的事情也不一样。
   - React 要调用`e.preventDefault()`。
      ```javascript
      function ActionLink() {
        function handleClick(e) {
          e.preventDefault();
          console.log('The link was clicked.');
        }

        return (
          <a href="#" onClick={handleClick}>
            Click me
          </a>
        );
      }
      ```
   - html 要`return false`。
     ```html
     <a href="#" onclick="console.log('The link was clicked.'); return false">
       Click me
     </a>
     ```

6. When using React you should generally not need to call `addEventListener` to add listeners to a DOM element after it is created. Instead, just provide a listener when the element is initially rendered.
   > 这句话并没有搞懂。

7. 