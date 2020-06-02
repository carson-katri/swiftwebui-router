# [SwiftWebUI](https://github.com/carson-katri/SwiftWebUI) Router

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

# Docs

## `Router`
A container for `Routes`.
Uses `location.pathname` to resolve which `Route` to render:
```swift
Router {
    ...
}
```

## `Route`
A map from a path to a View
Path can contains arguments, such as `/artists/:artistId/song/:songId`:
```swift
Route(to: "/artists/:artistId/song/:songId") { args in
    VStack {
        Text("Artist: \(args["artistId"])")
        Text("Song: \(args["songId"])")
    }
}
```

## `Navigator`
A way to navigate without using Views:
```swift
Navigator.back()
Navigator.navigateTo(["artists", "5"])
Navigator.navigateTo("/artists/5")
```

## `RouterLink`
A button that navigates to the specified path
```swift
RouterLink(to: "/artists") {
    Text("Back")
}
```

## `Redirect`
A View that redirects `onAppear`
```swift
Redirect(to: "/")
```
