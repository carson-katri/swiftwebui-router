//
//  Redirect.swift
//  
//
//  Created by Carson Katri on 6/2/20.
//

import SwiftWebUI

/// A View that redirects `onAppear`
public struct Redirect : View {
    public let destination: String
    
    public init(to destination: String) {
        self.destination = destination
    }

    public init(to destination: [String]) {
        self.init(to: destination.joined(separator: "/"))
    }
    
    public var body: some View {
        Text("")
            .onAppear {
                Navigator.navigateTo(destination)
            }
    }
}
