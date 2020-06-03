//
//  Router.swift
//
//
//  Created by Carson Katri on 6/2/20.
//

import SwiftWebUI
import JavaScriptKit

/// A container for `Route`s.
/// Uses `location.pathname` to resolve which `Route` to render
public struct Router : View {
    @ObservedObject private var path: Path = Path(Navigator.currentPath())
    let routes: [Route]

    public init(@RouterBuilder _ routes: () -> [Route]) {
        self.init(routes())
    }
    
    public init(_ routes: [Route]) {
        self.routes = routes
    }

    public var body: some View {
        resolve(Navigator.currentPath())
    }

    func resolve(_ path: [String]) -> some View {
        let route = routes.first(where: { Self.routeMatches(path: path, route: $0.path) })
        return Group {
            if route == nil {
                Text("404")
            } else {
                route!.content
            }
        }
    }

    public static func routeMatches(path: [String], route: [String]) -> Bool {
        if route.count != path.count {
            return false
        }
        for (i, component) in path.enumerated() {
            if component == route[i] || route[i].first == ":" {
                continue
            } else {
                return false
            }
        }
        return true
    }

    class Path: ObservableObject, Identifiable {
        let didChange = PassthroughSubject<Void, Never>()

        var currentPath: [String] = [] {
            didSet {
                didChange.send(())
            }
        }

        var id: String {
            currentPath.joined(separator: "/")
        }

        init(_ path: [String]) {
            self.currentPath = path
            JSObjectRef.global.history.object?.pushStateAndUpdate = .function { props in
                let res = JSObjectRef.global.history.object?.pushState?(props[0], props[1], props[2])
                self.currentPath = Navigator.currentPath()
                return res ?? .undefined
            }
        }
    }
}
