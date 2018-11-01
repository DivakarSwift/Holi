
import Foundation

// Currently, the only resolution supported is “days”. 

enum Resolution {
    case days

    var string: String {
        switch self {
        case .days:
            return "days"
        }
    }
}
