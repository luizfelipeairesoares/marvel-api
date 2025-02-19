//
//  MarvelImage.swift
//  portfolio
//
//

import Vapor

struct MarvelImage: Content {

    let path: String?
    let ext: String?

    var imageURL: URL? {
        guard let path = path, let ext = ext else {
            return nil
        }
        return URL(string: path + "." + ext)
    }

    private enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }

}
