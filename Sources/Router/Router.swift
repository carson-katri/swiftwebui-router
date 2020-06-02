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
    let path: [String]
    let routes: [Route]

    public init(@RouterBuilder _ routes: () -> [Route]) {
        self.routes = routes()
        guard let pathname = JSObjectRef.global.location.object?.pathname.string else {
            fatalError("Cannot access current site location")
        }
        self.path = pathname.split(separator: "/").map(String.init)
    }

    public var body: some View {
        resolve(path)
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

    static func routeMatches(path: [String], route: [String]) -> Bool {
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
}
