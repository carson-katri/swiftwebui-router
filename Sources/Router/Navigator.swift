//
//  Navigator.swift
//  
//
//  Created by Carson Katri on 6/2/20.
//
import JavaScriptKit

/// A way to navigate without using Views
public struct Navigator {
    public static func back() {
        _ = JSObjectRef.global.history.object?.back?()
    }

    public static func navigateTo(_ path: String) {
        JSObjectRef.global.location.object?.pathname = .string(path)
    }

    public static func navigateTo(_ path: [String]) {
        navigateTo(path.joined(separator: "/"))
    }
}
