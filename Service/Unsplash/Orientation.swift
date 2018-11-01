
import Foundation

enum Orientation {
    case landscape
    case portrait
    case squarish
    
    var string: String {
        switch self {
        case .landscape:
            return "landscape"
        case .portrait:
            return "portrait"
        case .squarish:
            return "squarish"
        }
    }
}
