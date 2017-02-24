//
//  BundleProtocol.swift
//
//
//  Created by blcsntb on 2/24/17.
//
//

import Foundation

public protocol BundleProtocol {
    func getBundleName() -> String?
}

public extension BundleProtocol {
    public var bundle: NSBundle? {
        if let bundleName = getBundleName() {
            return NSBundle(path: bundleName)
        }
        
        return nil
    }
}