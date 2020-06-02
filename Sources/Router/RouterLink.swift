//
//  RouterLink.swift
//  
//
//  Created by Carson Katri on 6/2/20.
//

import SwiftWebUI

public struct RouterLink<Content: View>: View {
    let destination: String
    let content: Content
    
    public init(to destination: String, @ViewBuilder _ content: () -> Content) {
        self.destination = destination
        self.content = content()
    }

    public init(to destination: [String], @ViewBuilder _ content: () -> Content) {
        self.init(to: destination.joined(separator: "/"), content)
    }

    public var body: some View {
        Button(action: {
            Navigator.navigateTo(destination)
        }) {
            content
        }
    }
}
