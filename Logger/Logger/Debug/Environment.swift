import Foundation

enum Configuration {
    case debug
    case production
}

enum Env {
    static let configuration: Configuration = {
        #if DEBUG
            let dic = ProcessInfo.processInfo.environment
            if let forceProduction = dic["forceProduction"], forceProduction == "true" {
                return .production
            }
            return .debug
        #else
            return .production
        #endif
    }()
}
