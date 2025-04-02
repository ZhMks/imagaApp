import Foundation

struct MainResponseModel: Codable {
    let id: String
    let likes: Int
    let urls: LinksResponseModel
    let user: UserResponseModel
    
}

struct UserResponseModel: Codable {
    let name: String
    let surname: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "first_name"
        case surname = "last_name"
    }
}

struct LinksResponseModel: Codable {
    let regular: String
    
    private enum CodingKeys: String, CodingKey {
        case regular = "regular"
    }
}

struct SearchResponseModel: Codable {
    let results: [MainResponseModel]
}
struct LocationResponseMode: Codable {
    let city: String?
    let country: String?
}
struct DetailResponseModel: Codable {
    let id: String
    let dateOfCreation: String
    let links: LinksResponseModel
    let user: UserResponseModel
    let downloads: Int
    let location: LocationResponseMode
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case dateOfCreation = "created_at"
        case links = "urls"
        case user = "user"
        case downloads = "downloads"
        case location = "location"
    }
}
