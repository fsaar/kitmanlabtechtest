import Foundation

extension Bundle {
    static var test: Bundle {
        Bundle(for: MockURLProtocol.self)
    }
}
