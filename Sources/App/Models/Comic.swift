//
//  Comic.swift
//  portfolio
//
//

import Vapor

struct Comic: Content {

    let id: Int
    let digitalId: Int
    let title: String
    let issueNumber: Int
    let description: String?
    let isbn: String
    let pageCount: Int
    let thumbnail: MarvelImage?
    let creators: Creators

}
