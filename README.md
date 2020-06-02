# SwiftWebUI Router

A simple Router for SwiftWebUI:

```swift
struct ContentView : View {
    var body: some View {
        Router {
            Route(path: "/") {
                Text("Hello, world!")
            }
            Route(path: "/:id") { args in
                Text("\(args["id"] ?? "")")
            }
        }
    }
}
```

If you want to use this with the webpack dev server you will have to make a few small changes to your webpack config:

```js
...
module.exports = {
  ...
  output: {
    ...
    // Add this
    publicPath: '/',
  },
  ...
  devServer: {
    ...
    // And this
    historyApiFallback: {
      index: 'index.html'
    }
  },
};
```
Now the server will always serve your index.html, no matter the route.
