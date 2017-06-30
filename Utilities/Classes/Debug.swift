import Foundation

public func println(_ item: Any, path: String = #file, line: Int = #line, function: String = #function) {
    print(path.fileNameWithoutExtension, terminator: ":")
    print(line, terminator: ":")
    print(function, terminator: ": ")
    print(item)
    print()
}

private extension String {
    private var nsString: NSString {
        return NSString(string: self)
    }
    
    var fileName: String {
        return nsString.lastPathComponent
    }
    
    var fileNameWithoutExtension: String {
        return fileName.nsString.deletingPathExtension
    }
}
