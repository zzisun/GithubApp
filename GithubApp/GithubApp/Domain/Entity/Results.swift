import Foundation

struct Results: Decodable {
    let totalCount: Int
    let repositories: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case repositories = "items"
    }
}
