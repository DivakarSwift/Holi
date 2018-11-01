
import Foundation

enum UnsplashSettings {
    case host
    case callbackURLScheme
    case clientID
    case clientSecret
    case authorizeURL
    case tokenURL
    case redirectURL
    
    var string: String {
        switch self {
        case .host:
            return "unsplash.com"
        case .callbackURLScheme:
            return "holi://"
        case .clientID:
            return UnsplashSecrets.clientID
        case .clientSecret:
            return UnsplashSecrets.clientSecret
        case .authorizeURL:
            return "https://unsplash.com/oauth/authorize"
        case .tokenURL:
            return "https://unsplash.com/oauth/token"
        case .redirectURL:
            return "holi://unsplash"
        }
    }

    enum UnsplashSecrets {

        //static let clientID = UnsplashSecrets.environmentVariable(named: "UNSPLASH_CLIENT_ID") ?? ""
        static let clientID = "0dd1dc721b7672e96f4bdf71af623fb68ea7b1d4829681744a4a08e0a8ef68c8"
        static let clientSecret = UnsplashSecrets.environmentVariable(named: "UNSPLASH_CLIENT_SECRET") ?? ""

        static func environmentVariable(named: String) -> String? {
            let processInfo = ProcessInfo.processInfo
            guard let value = processInfo.environment[named] else {
                print("‼️ Missing Environment Variable: '\(named)'")
                return nil
            }
            return value

        }
    }
}
