import Foundation

struct Results: Decodable {
    let repositories: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case repositories = "items"
    }
}
