import Foundation

struct Results: Decodable {
    let totalCount: Int
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

struct Repository: Decodable {
    let name: String
    let owner: Owner
    let description: String
    let starCount: Int
    let language: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case description
        case starCount = "stargazers_count"
        case language
    }
}
