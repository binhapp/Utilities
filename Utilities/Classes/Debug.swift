import Foundation

public func println(
    _ items: Any...,
    file: String = #file,
    line: Int = #line,
    function: String = #function)
{
    print(file.fileName, terminator: ":")
    print(line, terminator: ":")
    print(function, terminator: ": ")
    
    items.forEach {
        print($0, terminator: " ")
    }
    
    print()
}

public extension String {
    public var fileName: String {
        return fileNameExtension.nsString.deletingPathExtension
    }
    
    public var fileNameExtension: String {
        return nsString.lastPathComponent
    }
    
    public var nsString: NSString {
        return NSString(string: self)
    }
}
