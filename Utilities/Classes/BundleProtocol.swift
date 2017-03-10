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
    public var bundle: Bundle? {
        if let bundleName = getBundleName() {
            return Bundle(path: bundleName)
        }
        
        return nil
    }
}
