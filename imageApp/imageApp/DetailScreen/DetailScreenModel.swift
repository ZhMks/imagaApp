import UIKit

struct DetailScreenModel {
    let id: String
    let url: String?
    let authorName: String
    let authorSurname: String
    let downloads: Int
    let creationDate: String
    let location: DetailScreenLocationModel
    let image: UIImage?
}

struct DetailScreenLocationModel {
    let city: String?
    let country: String?
}
