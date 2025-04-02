import UIKit

struct MainScreenModel {
    let id: String
    let user: UserModel
    let likes: Int
    let links: Links
}

struct UserModel {
    let name: String
    let surname: String
}

struct Links {
    let raw: String
}
