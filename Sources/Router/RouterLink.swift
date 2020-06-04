//
//  RouterLink.swift
//  
//
//  Created by Carson Katri on 6/2/20.
//

import SwiftWebUI

/// A button that navigates to the specified path
public struct RouterLink<Content: View>: View {
    public let destination: String
    public let content: Content
    public let style: Style
    
    public init(to destination: String, style: Style = .button, @ViewBuilder _ content: () -> Content) {
        self.destination = destination
        self.content = content()
        self.style = style
    }

    public init(to destination: [String], style: Style = .button, @ViewBuilder _ content: () -> Content) {
        self.init(to: destination.joined(separator: "/"), style: style, content)
    }

    public var body: some View {
        Group {
            if style == .button {
                Button(action: self.navigate) {
                    content
                }
            } else if style == .plain {
                content.onTapGesture(self.navigate)
            } else {
                Text("")
            }
        }
    }
    
    func navigate() {
        Navigator.navigateTo(destination)
    }
    
    public enum Style {
        case button
        case plain
    }
}
