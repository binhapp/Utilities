//
//  LogUtils.swift
//
//
//  Created by blcsntb on 11/30/16.
//
//

import Foundation

private extension String {
    var nsString: NSString {
        return NSString(string: self)
    }
    var fileName: String {
        return nsString.lastPathComponent
    }
    var fileNameWithoutExtension: String {
        return fileName.nsString.deletingPathExtension
    }
}

open class LogUtils {
    open static func println(_ items: Any, path: String = #file, line: Int = #line, function: String = #function) {
        print(path.fileNameWithoutExtension, terminator: ":")
        print(line, terminator: ":")
        print(function, terminator: ": ")
        print(items)
        print()
    }
}
