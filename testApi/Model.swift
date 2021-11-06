
import Foundation

// MARK: - Welcome
struct UserResult: Codable {
    var results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    var name: Name
    var picture: Picture
}

struct Name: Codable {
    var first, last, title: String
}

struct Picture: Codable {
    var large: String
}
