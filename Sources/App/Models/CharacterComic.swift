//
//  CharacterComic.swift
//  portfolio
//
//

import Vapor

struct CharacterComics: Content {

    let available: Int
    let items: [CharacterComic]
    let returned: Int

}

struct CharacterComic: Codable, Identifiable {

    var id: String { name }
    let name: String

}
