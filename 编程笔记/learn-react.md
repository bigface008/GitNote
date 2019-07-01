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

   > 并没有搞懂这句话。

7. React里面，当你创建一个用于渲染的DOM结构的列表后（这个说法可能不太对），应当给予每个DOM结构一个`key`，类型为`string`，独立地标识每个DOM结构。

   当没有合适的`key`时，你很有可能利用`array.map((item, index) => {...})`这样的方式把`index`作为`key`，但是要注意，对于可能会变化的列表，使用列表的`index`作为`key`是不合适的（会影响性能）。

   > We don’t recommend using *indexes* for *keys* if the order of items may change. This can negatively impact performance and may cause issues with component state.
   
8. 列表的`key`应当放置在*最外侧*。

   - Wrong

      ```js
      function ListItem(props) {
        const value = props.value;
        return (
          <li key={value.toString()}>
            {value}
          </li>
        );
      }

      function NumberList(props) {
        const numbers = props.numbers;
        const listItems = numbers.map((number) =>
          <ListItem value={number} />
        );
        return (
          <ul>
            {listItems}
          </ul>
        );
      }

      const numbers = [1, 2, 3, 4, 5];
      ReactDOM.render(
        <NumberList numbers={numbers} />,
        document.getElementById('root')
      );
      ```

   - Correct

      ```js
      function ListItem(props) {
        return <li>{props.value}</li>;
      }

      function NumberList(props) {
        const numbers = props.numbers;
        const listItems = numbers.map((number) =>
          <ListItem key={number.toString()}
                    value={number} />
        );
        return (
          <ul>
            {listItems}
          </ul>
        );
      }

      const numbers = [1, 2, 3, 4, 5];
      ReactDOM.render(
        <NumberList numbers={numbers} />,
        document.getElementById('root')
      );
      ```

   A good rule of thumb is that *elements inside the map() call need keys.*

9. Keys serve as a hint to React but they don’t get passed to your components. If you need the same value in your component, pass it explicitly as a prop with a different name.

0. React中event传递参数的方法：

   ```javascript
   handleChange(event) {
     this.setState({ value: event.target.value });
   }
   // ...
   <input type="text" value={this.state.value} onChange={this.handleChange} />
   ```

   一个奇怪的现象：这里如果给`<input />`加一个`id={this.state.value}`的参数，在`handleChange()`中获取`event.target.id`会比`event.target.value`滞后一个更改。

1. 没有搞懂这东西咋用。

   ```html
   <input type="file" />
   ```

2. 当你有很多个Input Event需要简单处理的时候，可以这么做来把所有处理压缩到一个函数中进行：

   ```javascript
   class Reservation extends React.Component {
     constructor(props) {
       super(props);
       this.state = {
         isGoing: true,
         numberOfGuests: 2
       };
   
       this.handleInputChange = this.handleInputChange.bind(this);
     }

     handleInputChange(event) {
       const target = event.target;
       const value = target.type === 'checkbox' ? target.checked : target.value;
       const name = target.name;

       this.setState({
         [name]: value
       });
     }

     render() {
       return (
         <form>
           <label>
             Is going:
             <input
               name="isGoing"  // 把`props.name`设置为相应`state`中项目的名称。
               type="checkbox" // 设置类型，用于处理函数中的判断。
               checked={this.state.isGoing}
               onChange={this.handleInputChange} />
           </label>
           <br />
           <label>
             Number of guests:
             <input
               name="numberOfGuests"
               type="number"
               value={this.state.numberOfGuests}
               onChange={this.handleInputChange} />
           </label>
         </form>
       );
     }
   }
   ```

3. 如果你发现一个`Controlled Component`的值在你在代码中明确设置后仍然可以修改，那你很可能是把它的值设成了`undefined`或`null`。
