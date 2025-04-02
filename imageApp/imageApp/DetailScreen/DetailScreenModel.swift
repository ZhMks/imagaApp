import UIKit

struct DetailScreenModel {
    let url: String
    let authorName: String
    let authorSurname: String
    let downloads: Int
    let creationDate: String
    let location: DetailScreenLocationModel
}

struct DetailScreenLocationModel {
    let city: String?
    let country: String?
}
