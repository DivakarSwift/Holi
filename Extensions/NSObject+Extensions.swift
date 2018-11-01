import UIKit

extension NSObject {
  
  class var nameOfClass: String {
    return NSStringFromClass(self).components(separatedBy: ".").last!
  }
}

public func printWithParams(_ items: Any...) {
    #if DEBUG
        let output = items.map { "\($0)" }.joined(separator: " ")
        print(output, terminator: "\n")
    #endif
}
