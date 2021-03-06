//
//  Route.swift
//  
//
//  Created by Carson Katri on 6/2/20.
//
import SwiftWebUI
import JavaScriptKit

/// A map from a path to a View
/// Path can contains arguments, such as `/artists/:artistId/song/:songId`
public struct Route : View {
    public let path: [String]
    public let content: AnyView

    public init<Content: View>(path: String, @ViewBuilder _ content: () -> Content) {
        self.path = path.split(separator: "/").map(String.init)
        self.content = AnyView(content())
    }

    public typealias Arguments = [String:String]
    public init<Content: View>(path: String, @ViewBuilder _ content: (Arguments) -> Content) {
        self.path = path.split(separator: "/").map(String.init)
        let currentPath = Navigator.currentPath()
        if Router.routeMatches(path: currentPath, route: self.path) {
            var args = Arguments()
            for (i, component) in currentPath.enumerated() {
                if self.path[i].first == ":" {
                    args[String(self.path[i].dropFirst())] = component
                }
            }
            self.content = AnyView(content(args))
        } else {
            self.content = AnyView(Text(""))
        }
    }

    public var body: some View {
        content
    }
}
