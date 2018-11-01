
import Foundation

enum OrderBy: Int {
    case oldest = 0
    case latest
    case popular
    
    var string: String {
        switch self {
        case .latest:
            return "latest"
        case .oldest:
            return "oldest"
        case .popular:
            return "popular"
        }
    }
}
