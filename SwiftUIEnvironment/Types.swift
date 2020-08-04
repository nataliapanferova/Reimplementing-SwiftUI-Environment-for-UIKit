//
//  Types.swift
//  SwiftUIEnvironment
//
//  Created by Наталия Панферова on 3/08/20.
//  Copyright © 2020 Наталия Панферова. All rights reserved.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var isAuthenticated = false
    
    var authenticationString: String {
        if isAuthenticated {
            return "Authenticated"
        } else {
            return "Anonymous"
        }
    }
}

class AppSettings: ObservableObject {
    @Published var language = "English"
}

class Environment {
    
    static let updateChanged = Notification.Name("EnvironmentChangedUpdate")
    
    static let shared = Environment()
    
    private var sinks = [AnyCancellable]()
    var values = [Any]()
    
    private init() {}
    
    func register<T: ObservableObject>(_ value: T) {
        values.append(value)
        
        let sink = value.objectWillChange.sink { _ in
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Self.updateChanged, object: value)
            }
        }
        
        sinks.append(sink)
    }
    
}

protocol GlobalUpdating {
    func update()
}

extension GlobalUpdating {
    func registerForUpdates() {
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            
            if let result = child.value as? AnyGlobal {
                
                NotificationCenter.default.addObserver(
                    forName: Environment.updateChanged,
                    object: result.anyWrappedValue,
                    queue: .main
                ) { _ in
                    self.update()
                }
            }
        }
    }
}

@propertyWrapper struct Global<ObjectType: ObservableObject>: AnyGlobal {
    var wrappedValue: ObjectType
    var anyWrappedValue: Any { wrappedValue }
    
    init() {
        if let value = Environment.shared.values.first(
            where: { $0 is ObjectType }
        ) as? ObjectType {
            self.wrappedValue = value
        } else {
            fatalError("Missing type in environment.")
        }
    }
}

protocol AnyGlobal {
    var anyWrappedValue: Any { get }
}
