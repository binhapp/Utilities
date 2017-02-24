//
//  ClassProtocol.swift
//
//
//  Created by blcsntb on 2/21/17.
//
//

import Foundation

public protocol ClassProtocol: class {
    
}

public extension ClassProtocol {
    public static var className: String {
        return String(Self)
    }
}