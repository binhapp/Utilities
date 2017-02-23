//
//  ClassNameProtocol.swift
//
//
//  Created by blcsntb on 2/21/17.
//
//

import Foundation

public protocol ClassNameProtocol: class {
    
}

public extension ClassNameProtocol {
    public static var className: String {
        return String(Self)
    }
}