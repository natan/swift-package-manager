/*
 This source file is part of the Swift.org open source project

 Copyright 2015 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception

 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors
*/

/// The description for an individual target.
public final class Target {
    /// The description for an individual target or package dependency.
    public enum Dependency {
        /// A dependency on a target in the same project.
        case Target(name: String)
    }

    /// The name of the target.
    public let name: String

    /// The list of dependencies.
    public var dependencies: [Dependency]

    /// Construct a target.
    public init(name: String, dependencies: [Dependency] = []) {
        self.name = name
        self.dependencies = dependencies
    }
}

// MARK: TOMLable

extension Target.Dependency: TOMLConvertible {
    public func toTOML() -> String {
        switch self {
        case .Target(let name):
            return "\"\(name)\","
        }
    }
}

extension Target: TOMLConvertible {
    public func toTOML() -> String {
        var result = ""
        result += "name = \"\(name)\"\n"
        result += "dependencies = ["
        for dependency in dependencies {
            result += dependency.toTOML()
        }
        result += "]\n"
        return result
    }
}

// MARK: Equatable

extension Target : Equatable { }
public func ==(lhs: Target, rhs: Target) -> Bool {
    return (lhs.name == rhs.name &&
        lhs.dependencies == rhs.dependencies)
}

extension Target.Dependency : Equatable { }
public func ==(lhs: Target.Dependency, rhs: Target.Dependency) -> Bool {
    switch (lhs, rhs) {
    case (.Target(let a), .Target(let b)):
        return a == b
    }
}
